class Train
  attr_accessor :carriages, :speed, :current_station_id
  attr_reader :number, :type, :route

  def initialize(number, type, carriages)
    @number = number
    @type = type
    @carriages = carriages

    @speed = 0
  end

  def gain_speed
    self.speed += 10
  end

  def stop
    self.speed = 0
  end

  def add_carriage
    self.carriages += 1 if is_stopped?
  end

  def delete_carriage
    self.carriages -= 1 if is_stopped?
  end

  def route=(route)
    @route = route
    self.current_station_id = 0
  end

  def go
    route.stations.each { |station| go_to_the_next_station } if at_start?
  end

  def current_station
    route.stations[current_station_id]
  end

  def next_station
    route.stations[current_station_id + 1] if has_next?
  end

  def previous_station
    route.stations[current_station_id - 1] if has_previous?
  end

  private

  def go_to_the_next_station
    if has_next?
      gain_speed
      current_station.send_out(self)
      self.current_station_id += 1
      current_station.take(self)
      stop
    end
  end

  def at_start?
    current_station_id.zero?
  end

  def has_next?
    current_station_id < route.stations.size - 1
  end

  def has_previous?
    current_station_id > 0
  end

  def is_stopped?
    speed.zero?
  end
end
