require 'yaml'

#
# Config manages all the config information for Taco It's a
# simple YAML Hash that gets persisted to `~/.taco` on-disk. You may access it
# as a Hash:
#
#     Taco.config
#
module Taco
  class Config

    # The main config file for tweey
    FILE = "#{ENV['HOME']}/.tacorc"

    # Public: The attributes Hash for configuration options. The attributes
    # needed are dictated by each backend, but the `backend` option must be
    # present.
    attr_reader :attributes

    # Creates a new instance of Config.
    #
    # This will load the attributes from taco's config file, or bootstrap it
    # if this is a new install. Bootstrapping defaults to the YAML backend.
    #
    # @returns nothing.
    def initialize
      bootstrap unless File.exist?(file)
      load_attributes
    end

    # Saves an empty, barebones hash to @attributes for the purpose of
    # new user setup.
    #
    # @returns [Boolean] whether the attributes were saved.
    def bootstrap
      @attributes = {
        :storage    =>  "#{ENV['HOME']}/.tacos"
      }
      save
    end

    # Shorthand to returning values from the @attributes Hash
    #
    # @returns [String] value of the attribute
    def [](key)
      self.attributes[key]
    end

    # Assigns a key a value and saves
    #
    # @returns [String] value
    def []=(key, value)
      self.attributes[key.to_sym] = value
      save
      value
    end

    # Loads and parses the YAML file from disk into memory and stores
    # it in the attributes Hash.
    #
    # @returns nothing.
    def load_attributes
      @attributes = YAML.load_file(file).inject({}){|h,(k,v)| h[k.to_sym] = v;h}
    end

    # Accessor for the configuration file.
    #
    # @returns [String] file path.
    def file
      FILE
    end

    # Writes the in-memory YAML Hash to disk.
    #
    # @returns nothing.
    def save
      File.open(file, 'w') do |f|
        self.attributes.each {|key, value| f.write "#{key}: '#{value}'\n" }
      end
    end

  end
end
