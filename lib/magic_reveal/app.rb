require 'redcarpet'
require 'sinatra/base'
require 'magic_reveal/slide_renderer'
require 'magic_reveal/index_libber'

begin
  require 'better_errors'
  HAS_BETTER_ERRORS = true
rescue LoadError
  HAS_BETTER_ERRORS = false
end

module MagicReveal
  class App < Sinatra::Base
    if HAS_BETTER_ERRORS
      configure :development do
        use BetterErrors::Middleware
        BetterErrors.application_root = File.expand_path('../../..', __FILE__)
      end
    end

    set :public_folder, File.expand_path('reveal.js', Dir.getwd)

    helpers do
      def markdown
        @markdown ||= Redcarpet::Markdown.new(
          MagicReveal::SlideRenderer.new,
          :space_after_headers => true,
          :filter_html => true,
          :fenced_code_blocks => true,
          :no_intra_emphasis => true,
        )
      end

      def index_html_path
        @index_html_path ||= Pathname.pwd + 'reveal.js' + 'index.html'
      end
    end

    get '/' do
      slides = markdown.render File.read('slides.md')
      libber = MagicReveal::IndexLibber.new index_html_path.read
      libber.update_author       MagicReveal::Identifier.name
      libber.update_description  "A Magical Presentiation"
      libber.update_slides       slides
      libber.to_s
    end

  end
end
