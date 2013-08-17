require 'redcarpet'
require 'sinatra/base'
require 'magic_reveal/slide_renderer'
require 'magic_reveal/index_libber'
require 'magic_reveal/project_config'

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

    set :public_folder, Dir.getwd

    get '/' do
      slides = Pathname.pwd + 'slides.md'
      markdown =  SlideRenderer.markdown_renderer
      libber = IndexLibber.new

      libber.author = Identifier.name
      libber.slides = markdown.render slides.read

      config = ProjectConfig.new(Pathname.pwd + 'config.json')
      libber.add_github_forkme config.json['github'] if config.json.key? 'github'

      libber.to_s
    end

    get '/index.js' do
      content_type :js
      config = ProjectConfig.new(Pathname.pwd + 'config.json')
      config.to_s
    end

  end
end
