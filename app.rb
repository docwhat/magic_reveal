require 'sinatra'
require 'redcarpet'
require 'cgi'

class RenderSlides < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants

  def header(text, header_level)
    output = []
    if @has_slides
      output << "</section>"
    else
      @has_slides = true
    end
    output << "<section>"
    output << "<h#{header_level}>#{text}</h#{header_level}>"
    output.join("\n")
  end

  def block_code(code, language)
    output = []
    if language
      output << "<pre class=\"#{language}\">"
    else
      output << "<pre>"
    end
    output << "<code>"

    if code =~ /\A\s*@@source\s*=\s*(.*)\s\Z/
      output << CGI::escapeHTML(File.read($1))
    else
      output << CGI::escapeHTML(code)
    end
    output << "</code>"
    output << "</pre>"
    output.join("")
  end
end

get '/' do
  renderer = RenderSlides.new(
    :no_styles => true,
  )

  markdown = Redcarpet::Markdown.new(
    renderer,
    :space_after_headers => true,
    :filter_html => true,
    :fenced_code_blocks => true,
    :no_intra_emphasis => true,
  )

  @slides = markdown.render File.read('slides.md')
  erb :index
end
