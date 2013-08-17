require 'pathname'
require 'nokogiri'
require 'magic_reveal/identifier'

module MagicReveal
  # Mad Libs with Reveal.JS's index.html
  class IndexLibber
    attr_reader :html

    def initialize html_text=nil
      if html_text.nil?
        template_path = Pathname.new(__FILE__).dirname + 'template.html'
        html_text = template_path.read
      end
      @html = Nokogiri::HTML(html_text, &:noblanks)
      # Add autogenerated comment
      #html.children.first.add_previous_sibling(Nokogiri::XML::Comment.new("Generated at #{Time.now}"))
      html.root.children.first.before Nokogiri::XML::Comment.new(html, "Generated at #{Time.now}")
    end

    def set_meta name, content
      meta = html.at_css("meta[@name='#{name}']")
      if !meta
        meta = Nokogiri::XML::Node.new('meta', html)
        meta[:name]    = name

        parent = (head = html.at('head')) ? head : html.root
        parent << meta
      end
      meta[:content] = content
    end

    def title= title
      html.title = title
    end

    def author= author
      set_meta 'author', author
    end

    def description= description
      set_meta 'description', description
    end

    def theme= theme
      # <link rel="stylesheet" href="css/theme/default.css" id="theme">
      node = html.at_css("link#theme")
      if !node
        node = Nokogiri::XML::Node.new('link', html)
        node[:id]   = 'theme'
        node[:rel]  = 'stylesheet'

        parent = (head = html.at('head')) ? head : html.root
        parent << node
      end
      node[:href] = "css/theme/#{theme}.css"
    end

    def slides= text
      slides = Nokogiri::HTML.fragment(text).children
      container = html.at_css('div.reveal div.slides')
      container.children = slides
      headers = slides.css('h1', 'h2', 'h3', 'h4', 'h5', 'h6')
      self.title = headers.first.text unless headers.nil? || headers.empty?
    end

    def add_github_forkme project
      a = Nokogiri::XML::Node.new('a', html)
      a[:class] = 'fork-me'
      a[:style] = 'display: none;'
      a[:href] = "https://github.com/#{project}"
      img = Nokogiri::XML::Node.new('img', html)
      img[:style] = "position: absolute; top: 0; right: 0; border: 0;"
      img[:src]="https://a248.e.akamai.net/camo.github.com/e6bef7a091f5f3138b8cd40bc3e114258dd68ddf/687474703a2f2f73332e616d617a6f6e6177732e636f6d2f6769746875622f726962626f6e732f666f726b6d655f72696768745f7265645f6161303030302e706e67"
      img[:alt] = "Fork me on GitHub"
      script = Nokogiri::XML::Node.new('script', html)
      script.content = "if( !navigator.userAgent.match( /iphone|ipod|android|ipad|blackberry/gi  ) && !!document.querySelector  ) { document.querySelector('.fork-me' ).style.display = 'block'; }"

      parent = (body = html.at('body')) ? body : html.root
      parent << a
      a << img
      parent << script
    end

    def to_s
      html.to_html
    end
  end
end
