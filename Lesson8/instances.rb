# Module for instances storage
module Instances
  # Module for work with methods of classes
  module ClassMethods
    attr_accessor :instances

    def all
      instances
    end

    def find(id)
      instances[id]
    end
  end

  # Module for work with methods of instances
  module InstanceMethods
    protected

    def add(instance)
      type = self.class
      while type.methods.include?(:instances)
        type.instances ||= []
        type.instances << instance
        type = type.superclass
      end
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
