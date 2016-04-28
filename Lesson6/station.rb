require "./instances"
require "./validation_error"

class Station
  include Instances
  attr_reader :name, :trains

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

  def valid?
    validate!
  rescue
    false
  end

  protected

  def validate!
    raise ValidationError, "Name must contains 3 letters a-z or more" if name !~ name_pattern
    true
  end

  def name_pattern
    /^[a-z]{3,}$/i
  end
end
