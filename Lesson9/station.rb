require './instances'
require './validation_error'

# Class for work with stations
class Station
  include Instances
  attr_reader :name, :trains

  NAME_PATTERN = /^[a-z]{3,}$/i

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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    if name !~ NAME_PATTERN
      raise ValidationError, 'Name must contains 3 letters a-z or more'
    end
    true
  end
end
