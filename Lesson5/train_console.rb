require "./station"
require "./train"
require "./cargo_train"
require "./passanger_train"
require "./carriage"
require "./cargo_carriage"
require "./passanger_carriage"
require "./route"

class TrainConsole
  attr_reader :trains

  def start
    loop do
      help

      case gets.chomp
      when "exit"
        break
      when "create_station"
        create_station
      when "create_train"
        create_train
      when "add_carriage"
        add_carriage
      when "delete_carriage"
        delete_carriage
      when "move_train"
        move_train
      when "display_stations"
        display_stations
      else
        unknown_command
      end
    end
  end

  private # TrainConsole hasn't subclasses, helper methods

  def help
    puts ""
    puts 'Input "exit" for exit'
    puts 'Input "create_station" for create a station'
    puts 'Input "create_train for create a train'
    puts 'Input "add_carriage" for add a carriage'
    puts 'Input "delete_carriage" for delete a carriage'
    puts 'Input "move_train" for move a train'
    puts 'Input "display_stations" for display your stations'
    puts ""
  end

  def create_station
    name = station_input
    Station.new(name)
    puts "Station with name: #{name} has been created."
  end

  def create_train
    number, type, carriages_count = train_input
    create_train!(number, type, carriages_count)
  end

  def add_carriage
    index = choose_train

    if check_train_index?(index)
      puts "Wrong index"
    else
      train = Train.find(index)
      carriage = get_carriage(train.type)

      train.add_carriage(carriage)
      puts "Carriage has been added"
    end
  end

  def delete_carriage
    index = choose_train

    if check_train_index?(index)
      puts "Wrong index"
    else
      Train.find(index).delete_carriage
      puts "Carriage has been deleted"
    end
  end

  def move_train
    train_index = choose_train

    if check_train_index?(train_index)
      puts "Wrong index"
    else
      station_index = choose_station
      move_train!(train_index, station_index) unless check_station_index?(station_index)
    end
  end

  def display_stations
    index = choose_station
    station = Station.find(index)
    puts "Station #{index}, Trains:"
    puts station.trains unless station.nil?
  end

  def unknown_command
    puts "I don't know this command: #{input}, but you can add it ;)"
  end

  def choose_station
    stations = Station.get_all
    puts "Your stations"
    puts stations

    puts "Choose station by index from 0 to #{stations.size - 1}"
    gets.chomp.to_i
  end

  def choose_train
    trains = Train.get_all
    puts "Your trains:"
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    gets.chomp.to_i
  end

  def create_train!(number, type, carriages_count)
    carriage = get_carriage(type)
    train = get_train(number, type)
    carriages_count.times { train.add_carriage(carriage) }
    puts "Train with number #{number}, type #{type} has been created with #{carriages_count} carriages"
  end

  def station_input
    puts "Input name of the station"
    gets.chomp
  end

  def train_input
    puts "Input number of the train"
    number = gets.chomp

    puts 'Input type("cargo" for cargo or "passanger" for passanger) of the train'
    type = gets.chomp

    puts "Input count of carriages"
    carriages_count = gets.chomp.to_i

    return number, type, carriages_count
  end

  def get_train(number, type)
    case type
    when "cargo"
      CargoTrain.new(number, [])
    when "passanger"
      PassangerTrain.new(number, [])
    else
      Train.new(number, type, [])
    end
  end

  def get_carriage(type)
    case type
    when "cargo"
      CargoCarriage.new
    when "passanger"
      PassangerCarriage.new
    else
      Carriage.new
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
