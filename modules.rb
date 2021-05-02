module MetaAttr
  def self.included(base)
    base.extend ClassMethods
    base.send :include {attr_name}_history
  end
	
	module ClassMethods
	  def attr_accessor_with_history(attr_name)
	    attr_name = attr_name.to_s
	    attr_reader attr_name
	    class_eval %Q{
	      def #{attr_name}_history
	        @#{attr_name}_history || [nil] 
	      end

	      def #{attr_name}=(new_value)
	        @#{attr_name}_history ||= [nil] 
	        @#{attr_name}_history << @#{attr_name} = new_value
	      end
	    }
	  end
	end

  module {attr_name}_history
  	attr_name = attr_name.to_s
	  attr_reader attr_name
  	class_eval %Q{
    	def show_instance
    		@#{attr_name}_history { |attr_name| }
      end
    }
  end
end