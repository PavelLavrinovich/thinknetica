require './instances'
require './validation'

# Class for work with stations
class Station
  include Instances
  include Validation

  NAME_PATTERN = /^[a-z]{3,}$/i

  attr_reader :name, :trains

  validate :name, :format, NAME_PATTERN

  def initialize(name)
    @name = name
    @trains = []
    validate!
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

  def each_train
    block_given? ? trains.each { |train| yield(train) } : trains
  end
end
