# File storage for Taco
#
#
module Taco
  module Storage
    class Yaml

      # Creates a new Todo instance in-memory.
      #
      # Returns the persisted Todo instance.
      def initialize(options = {})
        @items = []
        bootstrap
        load_items
      end

      # The main tacos in the user's home directory
      FILE = File.expand_path('.tacos.yml')

      attr_accessor :items

      # Accessor for the todo list file
      #
      # Returns String file path
      def file
        @file ||= File.exist?(FILE) ? FILE : "#{ENV['HOME']}/.tacos.yml"
      end

      # Formats the current set of todos
      #
      # @return [Hash] lovely
      def to_hash
        @items.group_by(&:context).inject({}) do |h,(k,v)|
          h[k.to_sym] = v.map(&:text); h
        end
      end

      # Loads the yaml todos file and creates a hash
      #
      # Returns the items loaded from the file
      def load_items
        return @items unless YAML.load_file(file)

        YAML.load_file(file).each do |key, texts|
          texts.each do |text|
            @items << Item.new("#{text} #{key}") if key.to_s != '@done'
          end
        end
        @items
      end

      # Creates a new taco in the current directory
      #
      # @returns nothing
      def touch
        FileUtils.touch FILE
        bootstrap
      end

      # Creates a new todo file if none is present
      #
      # Returns nothing
      def bootstrap
        return if File.exist?(file)
        @items = [Taco::Item.new('Add an item! @empty')]
        save
      end

      # Saves the current list of todos to disk
      #
      # Returns nothing
      def save
        File.open(file, "w") {|f| f.write(to_hash.to_yaml) }
      end

    end
  end
end
