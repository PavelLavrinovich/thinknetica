class PassangerCarriage < Carriage
  attr_reader :places, :taked_places

  def initialize(places)
    @places = places
    @taked_places = 0
  end

  def take_a_place
    self.taked_places += 1 unless free_places.zero?
  end

  def free_places
    places - taked_places
  end

  private

  attr_writer :taked_places
end
