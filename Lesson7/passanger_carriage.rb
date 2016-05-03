require "./carriage_overflowed_error"
require "./validation_error"

class PassangerCarriage < Carriage
  attr_reader :places, :taked_places

  def initialize(places)
    super()
    validate!(places)
    @places = places
    @taked_places = 0
  end

  def take_a_place
    validate_free!
    self.taked_places += 1
  end

  def free_space
    places - taked_places
  end

  private

  attr_writer :taked_places

  def validate!(places)
    raise ValidationError, "Places count cant't be negative" if places < 0
    true
  end

  def validate_free!
    raise CarriageOverflowedError, "All places have been taken" if free_space.zero?
    true
  end
end
