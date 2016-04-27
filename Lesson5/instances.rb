module Instances
  module ClassMethods
    def get_all
      InstanceMethods::get_all
    end

    def find(id)
      InstanceMethods::get_all[id]
    end
  end

  module InstanceMethods
    protected
    @@instances = []

    def self.get_all
      @@instances
    end

    def add
      @@instances << self
    end
  end

  def self.included(receiver)
    receiver.extend         ClassMethods
    receiver.send :include, InstanceMethods
  end
end
