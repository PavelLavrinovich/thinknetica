module InstanceCounter
  module ClassMethods
    attr_accessor :instances
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances ||= 0
      self.class.instances += 1
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
