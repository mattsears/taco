require 'optparse'
require 'yaml'
require 'taco/color'
require 'taco/config'
require 'taco/item'
require 'taco/list'
require "taco/version"

$:.unshift File.join(File.dirname(__FILE__), *%w[.. lib])

#
# == Taco Module
#
# Stuff + Shell = Taco
#
# A simple command-line app that manages todo items
#
module Taco
  extend self
  extend Taco::Color

  # Parses command line arguments and does what needs to be done.
  #
  # @returns nothing
  def execute(*args)
    @options = parse_options(*args)
    case args.shift
    when 'list','ls'
      List.new(:filter => args.first).list
    when 'add','a'
      puts "Added: #{List.new.add(args.join(' '))}"
      List.new.list
    when 'delete', 'del', 'd'
      puts "Deleted: #{List.new.delete(args.first)}"
      List.new.list
    when 'done'
      puts "Done: #{List.new.done(args.shift.to_i)}"
      List.new.list
    when 'edit'
      system("`echo $EDITOR` #{List.new.file} &")
    when 'clear'
      puts "All #{List.new.clear!} todos cleared! #{List.new.clear!}"
    when 'bump'
      puts "Bump: #{List.new.bump(args.shift, args.first)}"
      List.new.list
    when 'init'
      puts "Taco town!"
      List.new.touch
    else
      puts @options
    end
  end

  # Return a new or existing instance of the config variables
  #
  def config
    @config ||= Taco::Config.new
  end

  # Set configuration variables to values passed in the command line options
  #
  def parse_options(*args)
    options = OptionParser.new do |opts|
      opts.banner = "\nUsage: taco [options] [command]"
      opts.separator "Taco holds stuff in a shell\n\n"
      opts.separator "Commands:"
      opts.separator "  add      Adds a new item"
      opts.separator "  del      Removes an item"
      opts.separator "  list     Prints all items"
      opts.separator "  init     Bootstraps tacos in this directory"
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
