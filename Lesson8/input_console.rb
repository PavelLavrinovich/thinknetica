require './station.rb'
require './train.rb'

# Module for input by console
module InputConsole
  protected

  def station_input
    puts 'Input name of the station'
    gets.chomp
  end

  def train_input
    puts 'Input number of the train'
    number = gets.chomp

    puts 'Input type of the train'
    type = gets.chomp.to_sym

    puts 'Input count of carriages'
    carriages_count = gets.chomp.to_i

    [number, type, carriages_count]
  end

  def carriage_input
    puts 'Input capacity of the carriage'
    gets.chomp.to_i
  end

  def choose_station
    stations = Station.all
    puts 'Your stations'
    puts stations

    puts "Choose station by index from 0 to #{stations.size - 1}"
    gets.chomp.to_i
  end

  def choose_train
    trains = Train.all
    puts 'Your trains:'
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    gets.chomp.to_i
  end

  def choose_cargo_carriage
    carriages = CargoCarriage.all
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
    carriages = PassangerCarriage.all
    puts 'Your carriages:'
    puts carriages
    puts "Choose passanger carriage by index from 0 to #{carriages.size - 1}"
    gets.chomp.to_i
  end

  def choose_station_and_call_after_check
    index = choose_station
    if check_station_index?(index)
      puts 'Wrong index'
    else
      yield(index)
    end
  end

  def choose_train_and_call_after_check
    index = choose_train
    if check_train_index?(index)
      puts 'Wrong index'
    else
      yield(index)
    end
  end

  def check_station_index?(index)
    Station.find(index).nil?
  end

  def check_train_index?(index)
    Train.find(index).nil?
  end
end
