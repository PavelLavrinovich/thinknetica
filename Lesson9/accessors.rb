# Module for work with special accesors
module Accessors
  # Module for class methods
  module ClassMethods
    def attr_accessor_with_history(*names)
      names.each do |name|
        define_methods(name)
      end
    end

    def strong_attr_accessor(name, type)
      sym_name = "@#{name}".to_sym
      define_method(name) { instance_variable_get sym_name }
      define_method("#{name}=") do |value|
        raise "Type should be #{type}" unless type == value.class
        instance_variable_set sym_name, value
      end
    end

    protected

    def define_methods(name)
      sym_name = "@#{name}".to_sym
      sym_history = "@#{name}_history".to_sym
      define_method(name) { instance_variable_get sym_name }
      define_method("#{name}=") do |value|
        instance_variable_set(sym_history, []) if empty_history?(sym_history)
        instance_variable_get(sym_history).send(:<<, value)
        instance_variable_set sym_name, value
      end
      define_method("#{name}_history") { instance_variable_get(sym_history) }
    end
  end

  # Module for instance methods
  module InstanceMethods
    protected

    def empty_history?(sym_history)
      instance_variable_get(sym_history).nil?
    end
  end

  def self.included(receiver)
    receiver.send :include, InstanceMethods
    receiver.extend         ClassMethods
  end
end
