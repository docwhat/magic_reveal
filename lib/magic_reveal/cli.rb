require 'magic_reveal/cli/options'
require 'forwardable'

module MagicReveal
  class Cli
    extend Forwardable

    # Helper method
    def self.run
      self.new.run
    end

    def_delegator :options, :command
    def_delegator :options, :project

    def options
      @options ||= Options.new
    end

    def run args=ARGV
      options.parse args
    end
  end
end
