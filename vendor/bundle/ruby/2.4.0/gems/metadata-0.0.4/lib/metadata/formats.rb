require 'metadata/formats/base'
require 'metadata/formats/json'
require 'metadata/formats/string'

module Metadata
  module Format
    
    def self.named(name, &block)
      Metadata::Formats.const_get(name.to_s.classify)
    end
    
  end
end