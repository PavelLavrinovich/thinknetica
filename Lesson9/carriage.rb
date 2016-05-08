require './manufacturer'
require './instances'
require './carriage_overflowed_error'
require './validation'

# Class for work with carriages
class Carriage
  include Manufacturer
  include Instances
  include Validation

  attr_reader :capacity, :filled_capacity
  validate :capacity, :positive

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
    validate!
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

  def validate_free!(capacity)
    if free_space < capacity
      raise CarriageOverflowedError, 'Carriage has been overflowed'
    end
    true
  end
end
