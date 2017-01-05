module Metadata
  module Formats
    class Base
      include ActionView::Helpers if defined? Rails
      
      attr_accessor :output
      attr_accessor :object
      
      def initialize(object, &block)
        @output = []        
        @object = object
        
        instance_exec(@object, &block)
      end
      
      def puts(str)
        str = str.capitalize if @output.empty?
        @output << str
      end
      
      def is(*args)
      end
      
      def was(*args)
      end
      
      def it(*args)
      end
      
      def around(*args)
      end
      
      def about(*args)
      end
      
      def with(*args)
      end
      
      def stop
      end
      
      protected
      
      def word(word)
        word.to_s # @todo Translate
      end
      
    end
  end
end