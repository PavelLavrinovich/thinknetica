require "./instances"

class Station
  include Instances
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
    add(self)
  end

  def take(train)
    trains << train
  end

  def send_out(train)
    trains.delete(train)
  end

  def trains_with_type(type)
    trains.select { |train| train.type == type }
  end
end
