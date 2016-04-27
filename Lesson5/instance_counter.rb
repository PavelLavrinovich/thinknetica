module InstanceCounter
  module ClassMethods
    def instances
      InstanceMethods::instances
    end
  end

  module InstanceMethods
    protected
    @@instances = 0
    def register_instance
      @@instances += 1
    end

    def self.instances
      @@instances
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
