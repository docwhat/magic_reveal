require 'forwardable'
require 'highline/import'

require 'magic_reveal/cli/options'
require 'magic_reveal/creator'
require 'magic_reveal/slide_renderer'
require 'magic_reveal/index_libber'
require 'magic_reveal/project_config'

module MagicReveal
  # Command line interface
  class Cli
    extend Forwardable

    def_delegator :options, :program_name
    def_delegator :options, :command
    def_delegator :options, :project

    attr_writer :creator

    # Helper method
    def self.run(args = ARGV)
      new.run args
    end

    # Action Classes
    def show_help # rubocop:disable MethodLength
      puts <<-EOF
Usage: #{program_name} <command>
  Magic reveal version: #{MagicReveal::VERSION}

  new <name>
    Creates new presentation in directory <name>

  force-reload
    Refreshes the reveal.js files. WARNING: This may override customizations!

  start [options]
    Starts serving the presentation in the current directory

  static
    Creates a static index.html file from your slides
      EOF
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

    def create_static # rubocop:disable MethodLength
      slides = Pathname.pwd + 'slides.md'
      markdown =  SlideRenderer.markdown_renderer
      libber = IndexLibber.new
      config = ProjectConfig.new(Pathname.pwd + 'config.json')

      libber.author = Identifier.name
      libber.slides = markdown.render slides.read

      libber.add_github_forkme config.json['github'] if config.json.key? 'github'

      index_html = Pathname.pwd + 'index.html'
      index_html.open('w') { |f| f.print libber }

      js_file = Pathname.pwd + 'index.js'
      js_file.open('w') { |f| f.print config.to_js }
    end

    def avenge_programmer
      puts 'The programmer messed up.'
      puts 'Please file a bug at https://github.com/docwhat/magic_reveal'
      exit 13
    end

    def options
      @options ||= Options.new
    end

    def run(args = ARGV) # rubocop:disable MethodLength, CyclomaticComplexity
      options.parse args

      case command
      when :new
        creator.create_project(project)
      when :force_reload
        theyre_sure = (ask('This may overwrite customizations. Are you sure? (y/N) ') { |q| q.limit = 1; q.case = :downcase }) == 'y' # rubocop:disable Semicolon
        creator.update_project(Dir.getwd) if theyre_sure
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
