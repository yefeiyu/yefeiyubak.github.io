module Metadata
  module Formats    
    class String < Base
      
      DICTIONARY = {
        'is' => {
          present: 'is',
          past: 'was'
        }
      }
      
      def initialize(object, &block)
        @next = {}
        super(object, &block)
      end
      
      def is(something, tense=:present)
        something = pairs(something) if something.is_a?(Hash)
        
        @output << statement(change_tense(word(:is), tense), something)
      end
      
      def was(something)
        is(something, :past)
      end
      
      def it(something)
        something = pairs(something) if something.is_a?(Hash)
        
        @output << statement(word(:it), something)
      end
      
      def with(hash)
        @output << ::String.new.tap do |s|
          hash.map do |k,v|
            k = k.to_s
            k = k.singularize if k.respond_to? :singularize and v == 1
            s << statement(word(:with), v, k)
          end
        end
      end
      
      def stop        
        @output << "."
        @next[:capitalize] = true
      end
      
      def around(*args)
        @output << statement(word(:around), args.first)
      end
      
      def and_
        @output << word(:and)
      end
      
      def to_s
        statement(*@output)
      end
      
      private
      
      def statement(*args)
        if @next[:capitalize]
          args[0] = args[0].to_s.capitalize
          @next.delete :capitalize
        end
        args.join(' ').strip.gsub(' .', '.')
      end
      
      def pairs(something)
        statement(something.keys.first, something.values.first)
      end
      
      def change_tense(verb, tense)
        DICTIONARY[verb][tense]
      end
    end
  end
end