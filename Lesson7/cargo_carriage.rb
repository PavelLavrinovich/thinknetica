require "./carriage_overflowed_error"
require "./validation_error"

class CargoCarriage < Carriage
  attr_reader :capacity, :filled_capacity

  def initialize(capacity)
    super()
    validate!(capacity)
    @capacity = capacity
    @filled_capacity = 0
  end

  def fill(capacity)
    validate_free!(capacity)
    self.filled_capacity += capacity
  end

  def free_space
    capacity - filled_capacity
  end

  private

  attr_writer :filled_capacity

  def validate!(capacity)
    raise ValidationError, "Capacity can't be negative" if capacity < 0
    true
  end

  def validate_free!(capacity)
    raise CarriageOverflowedError, "There is only #{empty_capacity} capacity left" if free_space < capacity
    true
  end
end
