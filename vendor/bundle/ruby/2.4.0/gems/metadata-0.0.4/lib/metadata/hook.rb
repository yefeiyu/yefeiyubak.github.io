module Metadata
  module Hook
    
    def metadata(args={})
      # Self right now is the object that has metadata on it
      return if self.class._metadata.nil?
      
      options = self.class._metadata.merge(args)
      format = Metadata::Format.named(options[:format])
      format.new(self, &options[:block])
    end
    
    module ClassMethods
      attr_accessor :_metadata
    
      def metadata(*args, &block)
        options = args.first.is_a?(Hash) ? args.first : {}
        self._metadata = {format: options[:format] || :string, block: block}
      end
    end
  end
end