module Taco
  class Command
    class << self

      # Parses command line arguments and does what needs to be done.
      #
      def execute(*args)
        @options = parse_options(*args)
        case args.shift
        when 'list','ls'
          List.new(:filter => args.first).list
        when 'add','a'
          puts "Added: #{List.new.add(args.join(' '))}"
        when 'delete', 'del', 'd'
          puts "Deleted: #{List.new.delete(args.first)}"
        when 'done'
          puts "Done: #{List.new.done(args.shift.to_i)}"
        when 'edit'
          system("`echo $EDITOR` #{List.new.file} &")
        when 'clear'
          puts "All #{List.new.clear!} todos cleared! #{List.new.clear!}"
        when 'bump'
          puts "Bump: #{List.new.bump(args.shift, args.first)}"
          List.new.list
        else
          puts @options
        end
      end

      # Set configuration variables to values passed in the command line options
      #
      def parse_options(*args)
        options = OptionParser.new do |opts|
          opts.banner = "\nUsage: taco [options] [command]"
          opts.separator ""
          opts.separator "Commands:"
          opts.separator "  add      Adds a new item"
          opts.separator "  del      Removes an item"
          opts.separator "  del      Prints all items"
          opts.separator ""
          opts.separator "Options:"
          opts.on('-h', '--help', 'Display this screen') { puts opts; exit }
          opts.on('-v', '--version', 'Display the current version') do
            puts Taco::VERSION
            exit
          end
        end
        options.parse!(args)
        options
      end

    end
  end
end
