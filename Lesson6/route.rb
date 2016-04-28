class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def from
    stations.first
  end

  def to
    stations.last
  end

  def add(station, at = default_insert_position)
    stations.insert(at, station)
  end

  def delete(station)
    stations.delete(station) if station != from && station != to
  end

  private # Route hasn't subclasses, system value

  def default_insert_position
    -2
  end
end
