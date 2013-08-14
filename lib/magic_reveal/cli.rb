require 'forwardable'

require 'magic_reveal/cli/options'
require 'magic_reveal/creator'

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
      when :help
        show_help
      else
        avenge_programmer
      end
    end
  end
end
