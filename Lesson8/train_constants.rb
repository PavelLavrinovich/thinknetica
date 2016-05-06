require './cargo_carriage'
require './passanger_carriage'

# Module for work with constants of train
module TrainConstants
  NUMBER_PATTERN = /^[a-z\d]{3}-?[a-z\d]{2}$/i
  TYPE_PATTERN = /^[a-z]{3,}$/i
  CARRIAGE_TYPES = {
    cargo: CargoCarriage, passanger: PassangerCarriage
  }.freeze

  protected

  def initial_speed
    0
  end

  def stop_speed
    0
  end

  def gain_speed_difference
    10
  end

  def start_station_id
    0
  end
end
