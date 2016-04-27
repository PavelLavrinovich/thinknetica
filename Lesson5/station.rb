class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
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
