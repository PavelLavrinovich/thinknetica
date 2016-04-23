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

  def add(station, at = -2)
    stations.insert(at, station)
  end

  def delete(station)
    stations.delete(station) if station != from && station != to
  end
end
