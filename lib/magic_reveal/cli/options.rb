module MagicReveal
  class Cli
    # Command line options
    class Options
      attr_accessor(
        :command,
        :project
      )

      def program_name
        @program_name ||= File.basename($PROGRAM_NAME)
      end

      def parse(args) # rubocop:disable MethodLength
        case args.first
        when 'new'
          if args.length != 2
            @command = :help
          else
            @command = :new
            @project = args[1]
          end
        when 'force-reload'
          @command = :force_reload
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
