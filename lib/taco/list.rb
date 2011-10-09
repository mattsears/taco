
module Taco

  # The Todo contains many Items. They exist as buckets in which to categorize
  # individual Items. The relationship is maintained in a simple array.
  #
  class List

    # Creates a new Todo instance in-memory.
    #
    # Returns the persisted Todo instance.
    def initialize(options = {})
      @options, @items = options, []
      bootstrap
      load_items
    end

    # The main todos in the user's home directory
    FILE = File.expand_path('.taco')

    # Allow to items to be accessible from the outside
    attr_accessor :items

    # Creates a new todo
    #
    # Example:
    #   @todo.add('lorem epsim etc @work')
    #
    # Returns the add todo Item
    def add(todo)
      save do
        @items.push(Item.new(todo)).last
      end
    end

    # Removes the todo
    #
    # Example:
    #   @todo.delete(1)
    #
    # Returns the deleted todo Item
    def delete(index)
      save do
        @items.delete_at(index.to_i-1)
      end
    end

    # Marks a todo as done
    #
    # Example:
    #   @todo.done(1)
    #
    # Returns the done todo Item
    def done(index)
      save do
        @items[index-1].context = '@done'
        @items[index-1]
      end
    end

    # Prints all the active todos in a nice neat format
    #
    # Examples:
    #   @todo.list @work
    #
    # Returns nothing
    def list(padding = 5)
      puts "\nTodos:"
      puts '-'*(max_length(:text) + max_length(:context) + padding + 3)
      @items.each_with_index do |todo, index|
        printf "%s: %-#{max_length(:text)+padding}s%s\n", index+1, todo.text, todo.context
      end
    end

    # Finds the longest string given the Item attribute
    #
    # Example:
    #   @todo.max_length(:text)  #=> 29
    #
    # Returns Fixnum size
    def max_length(attribute)
      @items.map(&attribute.to_sym).max_by(&:length).size
    end

    # Moves a todo up or down in priority
    #
    # Example:
    #   @todo.bump(2, +1)
    #
    def bump(index, position = 1)
      save do
        index, position = index.to_i-1, position.to_i-1
        @items.insert(position, @items.delete_at(index))
        @items[position]
      end
    end

    # Accessor for the todo list file
    #
    # Returns String file path
    def file
      @file ||= File.exist?(FILE) ? FILE : "#{ENV['HOME']}/.taco"
    end

    # Formats the current set of todos
    #
    # Returns a lovely hash
    def to_hash
      @items.group_by(&:context).inject({}) do |h,(k,v)|
        h[k.to_sym] = v.map(&:text); h
      end
    end

    # Loads the yaml todos file and creates a hash
    #
    # Returns the items loaded from the file
    def load_items
      YAML.load_file(file).each do |key, texts|
        texts.each do |text|
          if key.to_s == @options[:filter] || @options[:filter].nil?
            @items << Item.new("#{text} #{key}") if key.to_s != '@done'
          end
        end
      end
      @items
    end

    # Implodes all the todo items save an empty file
    #
    # Returns nothing
    def clear!
      @items.clear
      save
    end

    private

    # Saves the current list of todos to disk
    #
    # Returns nothing
    def save(&block)
      returning = yield if block_given?
      File.open(file, "w") {|f| f.write(to_hash.to_yaml) }
      returning
    end

    # Creates a new todo file if none is present
    #
    # Returns nothing
    def bootstrap
      return if File.exist?(file)
      @items = [Taco::Item.new('Add an item! @empty')]
      save
    end

  end
end
