require 'forwardable'

require 'magic_reveal/cli/options'
require 'magic_reveal/creator'
require 'magic_reveal/slide_renderer'
require 'magic_reveal/index_libber'

module MagicReveal
  class Cli
    extend Forwardable

    def_delegator :options, :program_name
    def_delegator :options, :command
    def_delegator :options, :project

    attr_writer :creator

    # Helper method
    def self.run args=ARGV
      self.new.run args
    end

    # Action Classes
    def show_help
      puts "Usage: #{program_name} <command>"
      puts
      puts "  new <name>"
      puts "    Creates new presentation in directory <name>"
      puts
      puts "  start [options]"
      puts "    Starts serving the presentation in the current directory"
      puts
      puts "  static"
      puts "    Creates a static index.html file from your slides"
      puts
      exit
    end

    def creator
      @creator ||= Creator.new(Dir.getwd)
    end

    def start_server
      require 'rack'
      ARGV.shift
      Rack::Server.start
      exit
    end

    def create_static
      slides = Pathname.pwd + 'slides.md'
      reveal_js_html = Pathname.pwd + 'reveal.js' + 'index.html'
      index_html = Pathname.pwd + 'index.html'

      markdown =  SlideRenderer.markdown_renderer
      slides = markdown.render slides.read
      libber = IndexLibber.new reveal_js_html.read
      libber.update_author       Identifier.name
      libber.update_description  "A Magical Presentiation"
      libber.update_slides       slides

      index_html.open('w') { |f| f.print libber.to_s }
    end

    def avenge_programmer
      puts "The programmer messed up."
      puts "Please file a bug at https://github.com/docwhat/magic_reveal"
      exit 13
    end

    def options
      @options ||= Options.new
    end

    def run args=ARGV
      options.parse args

      case command
      when :new
        creator.create_project(project)
      when :start
        start_server
      when :static
        create_static
      when :help
        show_help
      else
        avenge_programmer
      end
    end
  end
end
