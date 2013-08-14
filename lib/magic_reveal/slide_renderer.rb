require 'redcarpet'
require 'cgi'

module MagicReveal
  class SlideRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants
    attr_accessor :has_shown_slides

    def initialize
      super(no_styles: true)
    end

    def doc_header
      @has_shown_slides = false
      "<!-- generated by magic_reveal v#{VERSION} on #{Time.now} -->"
    end

    def doc_footer
      has_shown_slides ? '</section>' : ''
    end

    def header(text, header_level)
      output = []
      if has_shown_slides
        output << "</section>"
      else
        @has_shown_slides = true
      end
      output << "<section>"
      output << "<h#{header_level}>#{text}</h#{header_level}>"
      output.join("\n")
    end

    def prepare_code(code)
      if code =~ %r{\A\s*@@source\s*=\s*(.*)\s*\Z}
        File.read($1)
      else
        code
      end
    end

    def block_code(code, language)
      output = []
      if language
        output << "<pre class=\"#{language}\">"
      else
        output << "<pre>"
      end
      output << "<code>"

      output << CGI::escapeHTML(prepare_code code)
      output << "</code>"
      output << "</pre>"
      output.join("")
    end
  end
end
