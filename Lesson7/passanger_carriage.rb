require "./carriage_owerflowed_error"

class PassangerCarriage < Carriage
  attr_reader :places, :taked_places

  def initialize(places)
    @places = places
    @taked_places = 0
  end

  def take_a_place
    validate!
    self.taked_places += 1
  end

  def free_places
    places - taked_places
  end

  private

  attr_writer :taked_places

  def validate!
    raise CarriageOverflowedError, "All places have been taken" if free_places.zero?
    true
  end
end
