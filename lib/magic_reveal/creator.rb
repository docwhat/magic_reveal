require 'pathname'
require 'fileutils'

require 'magic_reveal/reveal_js_fetcher'

module MagicReveal
  class Creator
    attr_reader :directory
    attr_writer :reveal_js_fetcher

    def initialize(directory)
      @directory = Pathname.new directory
    end

    def reveal_js_fetcher
      @reveal_js_fetcher ||= RevealJsFetcher.new
    end

    def create_project(project)
      top_dir = directory + project
      reveal_dir = top_dir + 'reveal.js'

      top_dir.mkdir

      reveal_js_fetcher.save_to(reveal_dir)
    end
  end
end
