# Storage is the interface between multiple Backends. You can use Storage
# directly without having to worry about which Backend is in use.
#
module Taco
 module Storage

    def self.backend=(backend = :yaml)
      backend = backend.to_s.capitalize
      Taco::Storage.const_get(backend)
      Taco.config[:storage] = backend.downcase
    end

    def self.backend
      #Taco::Storage.const_get(Taco.config[:storage].capitalize).new
      Taco::Storage.const_get('Yaml').new
    end

  end
end
