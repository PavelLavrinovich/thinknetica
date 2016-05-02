require "./carriage_owerflowed_error"

class CargoCarriage < Carriage
  attr_reader :capacity, :filled_capacity

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
  end

  def fill(capacity)
    validate!
    filled_capacity += capacity
  end

  def empty_capacity
    capacity - filled_capacity
  end

  private

  attr_writer :filled_capacity

  def validate!(capacity)
    raise CarriageOverflowedError, "There is only #{empty_capacity} capacity left" if empty_capacity < capacity
    true
  end
end
