module MagicReveal
  class Cli
    class Options
      attr_accessor(
        :command,
        :project,
      )
      def parse args
        case args.first
        when 'new'
          if args.length != 2
            @command = :help
          else
            @command = :new
            @project = args[1]
          end
        when 'help'
          @command = :help
        else
          @command = :help
        end
      end
    end
  end
end
