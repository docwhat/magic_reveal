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
    def creator
      @creator ||= Creator.new(Dir.getwd)
    end

    def options
      @options ||= Options.new
    end

    def run args=ARGV
      options.parse args

      case command
      when :new
        creator.create_project(project)
      else
        puts "Usage: #{program_name}"
        puts
        puts "This isn't written yet."
      end
    end
  end
end
