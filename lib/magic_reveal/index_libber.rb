require 'pathname'
require 'nokogiri'
require 'magic_reveal/identifier'

module MagicReveal
  # Mad Libs with Reveal.JS's index.html
  class IndexLibber
    attr_reader :html

    def initialize html_text
      @html = Nokogiri::HTML(html_text, &:noblanks)
    end

    def update_author author
      if meta = html.at_xpath("//meta[@name='author']")
        meta.set_attribute('content', author)
      end
    end

    def update_description description
      if meta = html.at_xpath("//meta[@name='description']")
        meta.set_attribute('content', description)
      end
    end

    def update_slides slides_text
      slides = Nokogiri::HTML(slides_text).css('section')
      if container = html.at_css('div.reveal div.slides')
        container.children = slides
      end
      headers = slides.css('h1', 'h2', 'h3', 'h4', 'h5', 'h6')
      html.title = headers.first.text unless headers.nil? || headers.empty?
    end

    def to_s
      html.to_html
    end
  end
end
