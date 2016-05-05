require "./manufacturer"
require "./instances"
require "./carriage_overflowed_error"
require "./validation_error"

class Carriage
  include Manufacturer
  include Instances

  attr_reader :capacity, :filled_capacity

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
    validate!(capacity)
    add(self)
  end

  def fill(capacity)
    validate_free!(capacity)
    self.filled_capacity += capacity
  end

  def free_space
    capacity - filled_capacity
  end

  protected

  attr_writer :filled_capacity

  def validate!(capacity)
    raise ValidationError, "Capacity can't be negative" if capacity < 0
    true
  end

  def validate_free!(capacity)
    raise CarriageOverflowedError, "Carriage has been overflowed" if free_space < capacity
    true
  end
end
