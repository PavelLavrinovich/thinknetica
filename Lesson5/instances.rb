module Instances
  module ClassMethods
    attr_accessor :instances

    def get_all
      self.instances
    end

    def find(id)
      self.instances[id]
    end
  end

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
