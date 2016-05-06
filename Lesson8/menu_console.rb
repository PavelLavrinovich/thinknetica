require './create_console'
require './carriage_overflowed_error'
require './station'
require './train'
require './passanger_carriage'
require './cargo_carriage'

# Module for work with a menu by console
module MenuConsole
  include CreateConsole

  protected

  def add_carriage
    choose_train_and_call_after_check do |index|
      train = Train.find(index)
      capacity = carriage_input
      carriage = get_carriage(train.type, capacity)

      train.add_carriage(carriage)
      puts 'Carriage has been added'
    end
  end

  def delete_carriage
    choose_train_and_call_after_check do |index|
      Train.find(index).delete_carriage
      puts 'Carriage has been deleted'
    end
  end

  def move_train
    choose_train_and_call_after_check do |train_index|
      station_index = choose_station
      unless check_station_index?(station_index)
        move_train!(train_index, station_index)
      end
    end
  end

  def display_stations
    Station.all.each do |station|
      puts "Station: #{station.name}"
      display_station_trains!(station) do |train|
        display_train_carriages!(train)
      end
    end
  end

  def display_station_trains
    choose_station_and_call_after_check do |index|
      display_station_trains!(Station.find(index))
    end
  end

  def display_station_trains!(station)
    station.each_train do |train|
      puts "#{train.number}, #{train.type}, #{train.carriages.size}"
      yield(train) if block_given?
    end
  end

  def display_train_carriages
    choose_train_and_call_after_check do |index|
      display_train_carriages!(Train.find(index))
    end
  end

  def display_train_carriages!(train)
    train.each_carriage do |carriage, index|
      puts "#{index}, #{train.type}, #{carriage.free_space}"
    end
  end

  def take_a_place
    carriage = PassangerCarriage.find(choose_passanger_carriage)
    carriage.take_a_place
  rescue CarriageOverflowedError => e
    puts e.message
    retry
  end

  def fill_capacity
    carriage = CargoCarriage.find(choose_cargo_carriage)
    capacity = input_capacity
    carriage.fill(capacity)
  rescue CarriageOverflowedError => e
    puts e.message
    retry
  end

  def unknown_command
    puts "I don't know this command, but you can add it ;)"
  end
end
