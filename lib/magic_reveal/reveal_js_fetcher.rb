require 'fileutils'
require 'magic_reveal/version'
require 'magic_reveal/conductor'

module MagicReveal
  class RevealJsFetcher
    attr_reader :version
    attr_writer :conductor

    def initialize(version=REVEAL_JS_VERSION)
      @version = version
    end

    def zip_url
      "https://github.com/hakimel/reveal.js/archive/#{@version}.zip"
    end

    def conductor
      @conductor ||= Conductor.new zip_url
    end

    def save_to(reveal_dir)
      reveal_dir = Pathname.new reveal_dir

      Dir.mktmpdir do |tmpdir|
        zipfile = tmpdir + "fetching-#{REVEAL_JS_VERSION}.zip"
        conductor.fetch(zipfile)
        conductor.unpack(zipfile, reveal_dir)
      end
    end

    def save_important_parts_to(reveal_dir)
      reveal_dir = Pathname.new reveal_dir
      reveal_dir.mkdir unless reveal_dir.exist?

      Dir.mktmpdir do |tmpdir|
        tmp_reveal_dir = Pathname(tmpdir) + 'reveal.js'
        save_to(tmp_reveal_dir.to_s)
        tmp_reveal_dir.children.select(&:directory?).reject{|c| %w[test].include? c.basename.to_s}.each do |dir|
          FileUtils.cp_r(dir.to_s, reveal_dir.to_s)
        end
      end
    end
  end
end
