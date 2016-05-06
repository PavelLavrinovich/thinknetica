# Module for counting of instances
module InstanceCounter
  # Module for methods of classes
  module ClassMethods
    attr_accessor :instances
  end

  # Module for methods of instances
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
