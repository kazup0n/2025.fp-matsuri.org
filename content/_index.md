---
title: 'Home'
date: 2023-10-24
type: landing

design:
  # Default section spacing
  spacing: "6rem"

sections:
  - block: community/hero
    content:
      title: 関数型まつり
      announcement:
        text: "2025.6.14<span style='font-size:70%'> sat</span> – 15<span style='font-size:70%'> sun</span>"
      links:
        - name: X
          icon: brands/x
          href: "https://x.com/fp_matsuri"
          padding: 10px
        - name: Hatena Blog
          icon: custom/hatenablog
          href: "https://blog.fp-matsuri.org/"
    design:
      spacing:
        padding: [0, 0, 0, 0]
      css_class: "dark"
      background:
        color: "rgb(var(--color-primary))"
  - block: community/base
    content:
      title: About
      text: |
        関数型プログラミングのカンファレンス「関数型まつり」を開催します！

        関数型プログラミングはメジャーな言語・フレームワークに取り入れられ、広く使われるようになりました。そしてその手法自体も進化し続けています。その一方で「関数型プログラミング」というと「難しい・とっつきにくい」という声もあり、十分普及し切った状態ではありません。

        私たちは様々な背景の方々が関数型プログラミングを通じて新しい知見を得て、交流ができるような場を提供することを目指しています。普段から関数型言語を活用している方や関数型プログラミングに興味がある方はもちろん、最先端のソフトウェア開発技術に興味がある方もぜひご参加ください！
    design:
      spacing:
        padding: ["8rem", 0, "6rem", 0]
  - block: community/overview
    content:
      title: Overview
      text: |
          <div class="md:flex flex-wrap justify-between gap-x-8">
            <div style="min-width: 18rem">
              <h3 class="font-semibold">Dates</h3>
              <p>2025.6.14(土)〜15(日)</p>
            </div>
            <div style="min-width: 18rem">
              <h3 class="font-semibold">Place</h3>
              <p>中野セントラルパーク カンファレンス</p>
            </div>
          </div>
      map: |
        <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d25918.24822641297!2d139.64379899847268!3d35.707005772578796!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x6018f34668e0bc27%3A0x7d66caba722762c5!2z5Lit6YeO44K744Oz44OI44Op44Or44OR44O844Kv44Kr44Oz44OV44Kh44Os44Oz44K5!5e0!3m2!1sen!2sjp!4v1736684092765!5m2!1sen!2sjp" width="100%" height="400" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>

  - block: community/schedule
    content:
      title: Schedule
      schedule:
        - event: セッション応募開始
          at: 2025年初め
        - event: セッション採択結果発表
          at: 
        - event: チケット販売開始
          at: 2025年春頃
        - event: 関数型まつり開催
          at: 2025.6.14-15
          highlight: true

  - block: community/base
    content:
      title: Sponsors
      text: |
        <div class="border border-black rounded-xl px-8">
          <div class="text-3xl font-bold text-center py-8">スポンサー募集中！</div>
          <div class="text-md">
          関数型まつりの開催には、みなさまのサポートが必要です！現在、イベントを支援していただけるスポンサー企業を募集しています。関数型プログラミングのコミュニティを一緒に盛り上げていきたいという企業のみなさま、ぜひご検討ください。

          スポンサープランの詳細は、2025年初頭に公開を予定しております。
          ご興味をお持ちの企業様は、ぜひ[お問い合わせフォーム](https://scalajp.notion.site/1566d12253aa80229b3bc0a015497cb4?pvs=105)よりお気軽にご連絡ください。後日、担当者よりご連絡を差し上げます。
          </div>
        </div>
  - block: community/people
    content:
      title: Team
      # Choose which groups/teams of users to display.
      #   Edit `user_groups` in each user's profile to add them to one or more of these groups.
      user_groups:
        - 座長
        - スタッフ
      sort_by: Params.title
      sort_ascending: true
    design:
      # Show user's social networking links? (true/false)
      show_social: false
      # Show user's interests? (true/false)
      show_interests: false
      # Show user's role?
      show_role: false
      # Show user's organizations/affiliations?
      show_organizations: false
  # - block: stats
  #   content:
  #     items:
  #       - statistic: "1M+"
  #         description: |
  #           Websites built
  #           with Hugo Blox
  #       - statistic: "10k+"
  #         description: |
  #           GitHub stars
  #           since 2016
  #       - statistic: "3k+"
  #         description: |
  #           Discord community
  #           for support
  #   design:
  #     # Section background color (CSS class)
  #     css_class: "bg-gray-100 dark:bg-gray-900"
  #     # Reduce spacing
  #     spacing:
  #       padding: ["1rem", 0, "1rem", 0]
  # - block: features
  #   id: features
  #   content:
  #     title: Features
  #     text: Build your site with blocks 🧱
  #     items:
  #       - name: Optimized SEO
  #         icon: magnifying-glass
  #         description: Automatic sitemaps, RSS feeds, and rich metadata take the pain out of SEO and syndication.
  #       - name: Fast
  #         icon: bolt
  #         description: Super fast page load with Tailwind CSS and super fast site building with Hugo.
  #       - name: Easy
  #         icon: sparkles
  #         description: One-click deployment to GitHub Pages. Have your new website live within 5 minutes!
  #       - name: No-Code
  #         icon: code-bracket
  #         description: Edit and design your site just using rich text (Markdown) and configurable YAML parameters.
  #       - name: Highly Rated
  #         icon: star
  #         description: Rated 5-stars by the community.
  #       - name: Swappable Blocks
  #         icon: rectangle-group
  #         description: Build your pages with blocks - no coding required!
  # - block: cta-image-paragraph
  #   id: solutions
  #   content:
  #     items:
  #       - title: Build your future-proof website
  #         text: As easy as 1, 2, 3!
  #         feature_icon: check
  #         features:
  #           - "Future-proof - edit your content in text files"
  #           - "Website is generated by a single app, Hugo"
  #           - "No JavaScript knowledge required"
  #         # Upload image to `assets/media/` and reference the filename here
  #         image: build-website.png
  #         button:
  #           text: Get Started
  #           url: https://hugoblox.com/templates/
  #       - title: Large Community
  #         text: Join our large community on Discord - ask questions and get live responses
  #         feature_icon: bolt
  #         features:
  #           - "Dedicated support channel"
  #           - "3,000+ users on Discord"
  #           - "Share your site and get feedback"
  #         # Upload image to `assets/media/` and reference the filename here
  #         image: coffee.jpg
  #         button:
  #           text: Join Discord
  #           url: https://discord.gg/z8wNYzb
  #   design:
  #     # Section background color (CSS class)
  #     css_class: "bg-gray-100 dark:bg-gray-900"
  # - block: testimonials
  #   content:
  #     title: ""
  #     text: ""
  #     items:
  #       - name: "Hugo Smith"
  #         role: "Marketing Executive at X"
  #         # Upload image to `assets/media/` and reference the filename here
  #         image: "testimonial-1.jpg"
  #         text: "Awesome, so easy to use and saved me so much work with the swappable pre-designed sections!"
  #   design:
  #     spacing:
  #       # Reduce bottom spacing so the testimonial appears vertically centered between sections
  #       padding: ["6rem", 0, 0, 0]
  # - block: cta-card
  #   content:
  #     title: Build your future-proof website
  #     text: As easy as 1, 2, 3!
  #     button:
  #       text: Get Started
  #       url: https://hugoblox.com/templates/
  #   design:
  #     card:
  #       # Card background color (CSS class)
  #       css_class: "bg-primary-700"
  #       css_style: ""
---
