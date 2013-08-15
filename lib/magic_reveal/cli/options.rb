module MagicReveal
  class Cli
    class Options
      attr_accessor(
        :command,
        :project,
      )

      def program_name
        @program_name ||= File.basename($0)
      end

      def parse args
        case args.first
        when 'new'
          if args.length != 2
            @command = :help
          else
            @command = :new
            @project = args[1]
          end
        when 'start'
          @command = :start
        when 'static'
          @command = :static
        else # including help
          @command = :help
        end
      end
    end
  end
end
