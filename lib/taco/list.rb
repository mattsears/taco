require 'fileutils'

module Taco

  # A Taco contains many Items. They exist as buckets in which to categorize
  # individual Items. The relationship is maintained in a simple array.
  #
  class List
    include Taco::Color

    # Creates a new Todo instance in-memory.
    #
    # Returns the persisted Todo instance.
    def initialize(options = {})
      @options = options
    end

    # Creates a new todo
    #
    # Example:
    #   @todo.add('lorem epsim etc @work')
    #
    # Returns the add todo Item
    def add(item)
      save do
        items.push(Item.new(item)).last
      end
    end

    # Removes the todo
    #
    # Example:
    #   @taco.delete(1)
    #
    # Returns the deleted todo Item
    def delete(index)
      save do
        items.delete_at(index.to_i-1)
      end
    end

    # Marks a todo as done
    #
    # Example:
    #   @taco.done(1)
    #
    # Returns [Item] the done Item
    def done(index)
      save do
        items[index-1].context = '@done'
        items[index-1]
      end
    end

    # Prints all the active todos in a nice neat format
    #
    # Examples:
    #   @taco.list @work
    #
    # Returns nothing
    def list(padding = 5)
      puts "\nTACOS:"
      puts '-'*(max_length(:text) + max_length(:context) + padding + 3)

      items.each_with_index do |item, index|
        if item.context.to_s == @options[:filter] || @options[:filter].nil?
          printf("[%s] %-#{max_length(:text)+padding}s%s\n",
            index+1, item.text, colorize(item.context.gsub('@',''), :cyan))
        end
      end
    end

    # Finds the longest string given the Item attribute
    #
    # Example:
    #   @taco.max_length(:text)  #=> 29
    #
    # @return [Fixnum] size
    def max_length(attribute)
      return 0 if items.empty?
      items.map(&attribute.to_sym).max_by(&:length).size
    end

    # Moves a todo up or down in priority
    #
    # Example:
    #   @taco.bump(2)
    #
    # @return [Item]
    def bump(index)
      save do
        items.insert(0, items.delete_at(index.to_i-1))
        items.first
      end
    end

    # Implodes all the todo items save an empty file
    #
    # Returns nothing
    def clear!
      items.clear
      save
    end

    # Saves the current list of todos to disk
    #
    # Returns nothing
    def save(&block)
      returning = yield if block_given?
      Taco.storage.save
      returning
    end

    # Shortcut to Taco.storage.items
    #
    # Returns Array of Taco::Items
    def items
      Taco.storage.items
    end

  end
end
