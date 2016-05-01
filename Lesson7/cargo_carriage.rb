class CargoCarriage < Carriage
  attr_reader :capacity, :filled_capacity

  def initialize(capacity)
    @capacity = capacity
    @filled_capacity = 0
  end

  def fill(capacity)
    filled_capacity += capacity if empty_capacity <= capacity
  end

  def empty_capacity
    capacity - filled_capacity
  end

  private

  attr_writer :filled_capacity
end
