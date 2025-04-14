module Route.Sponsors exposing (ActionData, Data, Model, Msg, data, route)

import BackendTask exposing (BackendTask)
import BackendTask.Glob as Glob
import Css exposing (..)
import Css.Extra exposing (marginBlock)
import FatalError exposing (FatalError)
import Head
import Head.Seo
import Html as PlainHtml
import Html.Attributes as PlainAttributes
import Html.Styled as Html exposing (Html, div, text)
import Html.Styled.Attributes exposing (class, css)
import Json.Decode as Decode exposing (Decoder)
import Markdown.Block exposing (Block)
import Markdown.Html
import Markdown.Renderer exposing (Renderer)
import PagesMsg exposing (PagesMsg)
import Plugin.MarkdownCodec
import RouteBuilder exposing (App, StatelessRoute)
import Shared
import Site
import View exposing (View)


type alias Model =
    {}


type alias Msg =
    ()


type alias RouteParams =
    {}


type alias Data =
    List SponsorArticle


type alias ActionData =
    {}


route : StatelessRoute RouteParams Data ActionData
route =
    RouteBuilder.single { head = head, data = data }
        |> RouteBuilder.buildNoState { view = view }


data : BackendTask FatalError Data
data =
    sponsorsData


head :
    App Data ActionData RouteParams
    -> List Head.Tag
head _ =
    Site.summaryLarge { pageTitle = "" }
        |> Head.Seo.website



-- DATA


type alias SponsorArticle =
    { metadata : SponsorMetadata
    , body : List Block
    }


type Plan
    = Gold
    | Silver
    | Logo


planDecoder : Decoder Plan
planDecoder =
    Decode.string
        |> Decode.andThen
            (\value ->
                case value of
                    "ゴールド" ->
                        Decode.succeed Gold

                    "シルバー" ->
                        Decode.succeed Silver

                    "ロゴ" ->
                        Decode.succeed Logo

                    _ ->
                        Decode.fail ("無効なプランです: " ++ value)
            )


type alias SponsorMetadata =
    { name : String
    , plan : Plan
    , postedAt : String
    }


metadataDecoder : Decoder SponsorMetadata
metadataDecoder =
    Decode.map3 SponsorMetadata
        (Decode.field "name" Decode.string)
        (Decode.field "plan" planDecoder)
        (Decode.field "postedAt" Decode.string)


{-| content/sponsors 直下にあるMarkdownファイルを取得するためのBackendTask
-}
sponsorFiles : BackendTask FatalError (List { filePath : String, slug : String })
sponsorFiles =
    Glob.succeed (\f s -> { filePath = f, slug = s })
        |> Glob.captureFilePath
        |> Glob.match (Glob.literal "content/sponsors/")
        |> Glob.capture Glob.wildcard
        |> Glob.match (Glob.literal ".md")
        |> Glob.toBackendTask


sponsorsData : BackendTask FatalError Data
sponsorsData =
    sponsorFiles
        |> BackendTask.map
            (List.map
                (\d ->
                    Plugin.MarkdownCodec.withFrontmatter SponsorArticle
                        metadataDecoder
                        customizedHtmlRenderer
                        d.filePath
                )
            )
        |> BackendTask.andThen BackendTask.combine



-- VIEW


view :
    App Data ActionData RouteParams
    -> Shared.Model
    -> View (PagesMsg Msg)
view d _ =
    { title = ""
    , body = [ sponsorsSection d.data ]
    }


sponsorsSection : Data -> Html msg
sponsorsSection pageData =
    Html.section []
        [ div [ css [ maxWidth (em 32.5) ] ]
            (List.map
                (\f ->
                    div
                        [ css
                            [ marginBlock (px 40)
                            , borderTop3 (px 5) solid (rgb 246 246 246)
                            , firstChild [ borderTopStyle none ]
                            ]
                        ]
                        [ div
                            [ css
                                [ marginTop (px 15)
                                , fontSize (px 28)
                                ]
                            ]
                            [ text f.metadata.name ]
                        , div
                            [ css [ marginTop (px 20) ], class "markdown-html-workaround" ]
                            (sponsorBody f.body)
                        ]
                )
                pageData
            )
        ]


sponsorBody : List Block -> List (Html msg)
sponsorBody body =
    body
        |> Markdown.Renderer.render customizedHtmlRenderer
        |> Result.map (List.map (\x -> Html.fromUnstyled x))
        |> (\r ->
                case r of
                    Err m ->
                        Ok [ text m ]

                    Ok m ->
                        Ok m
           )
        |> Result.withDefault []


{-| スポンサー記事のmarkdownからHTMLに変換するためのRendererです。

Slug\_.mdにあるcustomizedHtmlRendererとほぼ同じですが、以下が異なります。

  - いくつかの対応タグの追加
  - importのコンフリクトよけのためPlain〜という名前を使用

-}
customizedHtmlRenderer : Renderer (PlainHtml.Html msg)
customizedHtmlRenderer =
    let
        renderer =
            Markdown.Renderer.defaultHtmlRenderer
    in
    { renderer
        | link =
            \{ title, destination } children ->
                let
                    externalLinkAttrs =
                        -- Markdown記法で記述されたリンクについて、参照先が外部サイトであれば新しいタブで開くようにする
                        if isExternalLink destination then
                            [ PlainAttributes.target "_blank", PlainAttributes.rel "noopener" ]

                        else
                            []

                    isExternalLink url =
                        let
                            isProduction =
                                String.startsWith url "https://2025.fp-matsuri.org"

                            isLocalDevelopment =
                                String.startsWith url "/"
                        in
                        not (isProduction || isLocalDevelopment)

                    titleAttrs =
                        title
                            |> Maybe.map (\title_ -> [ PlainAttributes.title title_ ])
                            |> Maybe.withDefault []
                in
                PlainHtml.a (PlainAttributes.href destination :: externalLinkAttrs ++ titleAttrs) children
        , html =
            Markdown.Html.oneOf
                -- Markdown記述の中でHTMLの使用を許可する場合には、この部分にタグを指定する。
                [ -- iframe: 行動規範ページに埋め込まれたYouTube動画を想定
                  Markdown.Html.tag "iframe"
                    (\class_ width_ height_ src_ frameborder_ allow_ allowfullscreen_ children ->
                        PlainHtml.iframe
                            [ PlainAttributes.class class_
                            , PlainAttributes.attribute "width" width_
                            , PlainAttributes.attribute "height" height_
                            , PlainAttributes.src src_
                            , PlainAttributes.attribute "frameborder" frameborder_
                            , PlainAttributes.attribute "allow" allow_
                            , PlainAttributes.attribute "allowfullscreen" allowfullscreen_
                            ]
                            children
                    )
                    |> Markdown.Html.withAttribute "class"
                    |> Markdown.Html.withAttribute "width"
                    |> Markdown.Html.withAttribute "height"
                    |> Markdown.Html.withAttribute "src"
                    |> Markdown.Html.withAttribute "frameborder"
                    |> Markdown.Html.withAttribute "allow"
                    |> Markdown.Html.withAttribute "allowfullscreen"

                -- スポンサー記事向けに追加
                , Markdown.Html.tag "p" (\children -> PlainHtml.p [] children)
                , Markdown.Html.tag "b" (\children -> PlainHtml.b [] children)
                , Markdown.Html.tag "li" (\children -> PlainHtml.li [] children)
                , Markdown.Html.tag "ul" (\children -> PlainHtml.ul [] children)
                , Markdown.Html.tag "a"
                    (\href_ children ->
                        PlainHtml.a
                            [ PlainAttributes.href href_
                            , PlainAttributes.target "_blank"
                            , PlainAttributes.rel "noopener"
                            ]
                            children
                    )
                    |> Markdown.Html.withAttribute "href"
                ]
    }
