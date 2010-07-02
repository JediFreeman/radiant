require 'active_record'

class ActiveRecord::Base
  def self.object_id_attr(symbol, klass)
    module_eval %{
      def #{symbol}
        if @#{symbol}.nil? or (@old_#{symbol}_id != #{symbol}_id)
          @old_#{symbol}_id = #{symbol}_id
          klass = #{klass}.descendants.find { |d| d.#{symbol}_name == #{symbol}_id }
          klass ||= #{klass}
          @#{symbol} = klass.new
        else
          @#{symbol}
        end
      end
    }
  end
  def self.clear_validations
    @validate_callbacks = []
  end
  def self.remove_validation(sym)
    @validate_callbacks.reject! { |validation| validation.options[:validator_name] == sym }
  end
  def self.remove_validation_group(sym)
    @validate_callbacks.reject! { |validation| validation.options[:validator_group] == sym }
  end
end
