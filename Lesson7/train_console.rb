require './station'
require './train'
require './cargo_train'
require './passanger_train'
require './carriage'
require './cargo_carriage'
require './passanger_carriage'
require './route'
require './validation_error'
require './carriage_overflowed_error'

class TrainConsole
  attr_reader :trains

  DEFAULT_CARRIAGE_CAPACITY = 100

  def start
    loop do
      help

      case gets.chomp
      when 'exit'
        break
      when 'create_test_data'
        create_test_data
      when 'create_station'
        create_station
      when 'create_train'
        create_train
      when 'add_carriage'
        add_carriage
      when 'delete_carriage'
        delete_carriage
      when 'move_train'
        move_train
      when 'display_stations'
        display_stations
      when 'display_station_trains'
        display_station_trains
      when 'display_train_carriages'
        display_train_carriages
      when 'take_a_place'
        take_a_place
      when 'fill_capacity'
        fill_capacity
      else
        unknown_command
      end
    end
  end

  private # TrainConsole hasn't subclasses, helper methods

  def help
    puts ''
    puts 'Input "exit" for exit'
    puts 'Input "create_test_data" for create test data'
    puts 'Input "create_station" for create a station'
    puts 'Input "create_train for create a train'
    puts 'Input "add_carriage" for add a carriage'
    puts 'Input "delete_carriage" for delete a carriage'
    puts 'Input "move_train" for move a train'
    puts 'Input "display_stations" for display your stations'
    puts 'Input "display_station_trains" for display the trains on the station'
    puts 'Input "display_train_carriages" for display the carriages of the train'
    puts 'Input "take_a_place" for take a place'
    puts 'Input "fill_capacity" for fill some capacity'
    puts ''
  end

  def create_test_data
    5.times do |index|
      create_station!('Station')
      create_train!("CAR-#{index}#{index}", 'cargo', 5)
      create_train!("PAS-#{index}#{index}", 'passanger', 3)
      move_train!(2 * index, index)
      move_train!(2 * index + 1, index)
    end
  rescue ValidationError => e
    puts e.message
  end

  def create_station
    name = station_input
    create_station!(name)
  rescue ValidationError => e
    puts e.message
    retry
  end

  def create_train
    number, type, carriages_count = train_input
    create_train!(number, type, carriages_count)
  rescue ValidationError => e
    puts e.message
    retry
  end

  def add_carriage
    index = choose_train

    if check_train_index?(index)
      puts 'Wrong index'
    else
      train = Train.find(index)
      capacity = carriage_input
      carriage = get_carriage(train.type, capacity)

      train.add_carriage(carriage)
      puts 'Carriage has been added'
    end
  end

  def delete_carriage
    index = choose_train

    if check_train_index?(index)
      puts 'Wrong index'
    else
      Train.find(index).delete_carriage
      puts 'Carriage has been deleted'
    end
  end

  def move_train
    train_index = choose_train

    if check_train_index?(train_index)
      puts 'Wrong index'
    else
      station_index = choose_station
      move_train!(train_index, station_index) unless check_station_index?(station_index)
    end
  end

  def display_stations
    Station.get_all.each do |station|
      puts "Station: #{station.name}"
      display_station_trains!(station) { |train| display_train_carriages!(train) }
    end
  end

  def display_station_trains
    index = choose_station

    if check_station_index?(index)
      puts 'Wrong index'
    else
      display_station_trains!(Station.find(index))
    end
  end

  def display_station_trains!(station)
    station.each_train do |train|
      puts "Train, number: #{train.number}, type: #{train.type}, carriages count: #{train.carriages.size}"
      yield(train) if block_given?
    end
  end

  def display_train_carriages
    index = choose_train

    if check_train_index?(index)
      puts 'Wrong index'
    else
      display_train_carriages!(Train.find(index))
    end
  end

  def display_train_carriages!(train)
    train.each_carriage do |carriage, index|
      puts "Number: #{index}, type: #{train.type}, free space: #{carriage.free_space}"
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

  def choose_station
    stations = Station.get_all
    puts 'Your stations'
    puts stations

    puts "Choose station by index from 0 to #{stations.size - 1}"
    gets.chomp.to_i
  end

  def choose_train
    trains = Train.get_all
    puts 'Your trains:'
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    gets.chomp.to_i
  end

  def choose_cargo_carriage
    carriages = CargoCarriage.get_all
    puts 'Your carriages:'
    puts carriages
    puts "Choose cargo carriage by index from 0 to #{carriages.size - 1}"
    gets.chomp.to_i
  end

  def input_capacity
    puts 'Input capacity'
    gets.chomp.to_i
  end

  def choose_passanger_carriage
    carriages = PassangerCarriage.get_all
    puts 'Your carriages:'
    puts carriages
    puts "Choose cargo carriage by index from 0 to #{carriages.size - 1}"
    gets.chomp.to_i
  end

  def create_train!(number, type, carriages_count)
    train = get_train(number, type)
    carriages_count.times { train.add_carriage(get_carriage(type)) }
    puts "Train with number #{number}, type #{type} has been created with #{carriages_count} carriages"
  end

  def create_station!(name)
    Station.new(name)
    puts "Station with name: #{name} has been created."
  end

  def station_input
    puts 'Input name of the station'
    gets.chomp
  end

  def train_input
    puts 'Input number of the train'
    number = gets.chomp

    puts 'Input type("cargo" for cargo or "passanger" for passanger) of the train'
    type = gets.chomp

    puts 'Input count of carriages'
    carriages_count = gets.chomp.to_i

    [number, type, carriages_count]
  end

  def carriage_input
    puts 'Input capacity of the carriage'
    gets.chomp.to_i
  end

  def get_train(number, type)
    case type
    when 'cargo'
      CargoTrain.new(number, [])
    when 'passanger'
      PassangerTrain.new(number, [])
    else
      Train.new(number, type, [])
    end
  end

  def get_carriage(type, capacity = DEFAULT_CARRIAGE_CAPACITY)
    case type
    when 'cargo'
      CargoCarriage.new(capacity)
    when 'passanger'
      PassangerCarriage.new(capacity)
    else
      Carriage.new(capacity)
    end
  end

  def move_train!(train_index, station_index)
    train = Train.find(train_index)
    route = Route.new(train.current_station, Station.find(station_index))
    train.route = route
    train.go
    puts "Train went from #{route.from} to #{route.to}"
  end

  def check_station_index?(index)
    Station.find(index).nil?
  end

  def check_train_index?(index)
    Train.find(index).nil?
  end
end
