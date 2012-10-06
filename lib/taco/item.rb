module Taco

  # Represents a single todo item. An Item contains just a text and
  # a context.
  #
  class Item
    attr_accessor :context, :text

    # Creates a new Item instance in-memory.
    #
    # value - The text of the Todo. Context is extracted if exists.
    #
    # Returns the unpersisted Item instance.
    def initialize(value)
      @context = value.scan(/@[A-Z0-9.-]+/i).last || '@'
      @text    = value.gsub(context, '').strip
    end

    # Overide: Quick and simple way to print Items
    #
    # Returns String for this Item
    def to_s
      "#{@text}: #{@context}"
    end

  end
end
