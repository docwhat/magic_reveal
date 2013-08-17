require 'fileutils'
require 'pathname'

require 'magic_reveal/version'
require 'magic_reveal/reveal_js_fetcher'
require 'magic_reveal/project_config'

module MagicReveal
  class Creator
    attr_reader :directory
    attr_writer :reveal_js_fetcher, :template_slides, :template_config_ru

    def initialize(directory)
      @directory = Pathname.new directory
    end

    def reveal_js_fetcher
      @reveal_js_fetcher ||= RevealJsFetcher.new
    end

    def template_slides
      @template_slides ||= Pathname.new(__FILE__).dirname.dirname.dirname + 'README.md'
    end

    def template_config_ru
      @template_config_ru ||= Pathname.new(__FILE__).dirname + 'template-config.ru'
    end

    def create_project(project)
      top_dir = directory + project
      gemfile = top_dir + 'Gemfile'

      top_dir.mkdir

      reveal_js_fetcher.save_important_parts_to(top_dir)

      FileUtils.copy_file template_slides.to_s, (top_dir + 'slides.md').to_s
      FileUtils.copy_file template_config_ru.to_s, (top_dir + 'config.ru').to_s
      FileUtils.copy_file ProjectConfig::DEFAULT_TEMPLATE.to_s, (top_dir + 'config.json').to_s
      gemfile.open('w') do |f|
        f.puts "source 'https://rubygems.org'"
        f.puts
        f.puts "gem 'magic_reveal', '~> #{VERSION}'"
      end

      Dir.chdir(top_dir.to_s) do
        system 'bundle install'
      end
    end
  end
end
