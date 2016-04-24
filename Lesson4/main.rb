require "./station"
require "./train"
require "./special_train"
require "./cargo_train"
require "./passanger_train"
require "./carriage"
require "./cargo_carriage"
require "./passanger_carriage"
require "./route"

stations = []
trains = []

loop do
  puts ""
  puts 'Input "exit" for exit'
  puts 'Input "create_station" for create a station'
  puts 'Input "create_train for create a train'
  puts 'Input "add_carriage" for add a carriage'
  puts 'Input "delete_carriage" for delete a carriage'
  puts 'Input "move_train" for move a train'
  puts 'Input "stations" for display your stations'
  puts ""

  input = gets.chomp
  if input == "exit"
    break
  elsif input == "create_station"
    puts "Input name of the station"
    name = gets.chomp
    stations << Station.new(name)
    puts "Station with name: #{name} has been created."
  elsif input == "create_train"
    puts "Input number of the train"
    number = gets.chomp

    puts 'Input type("cargo" for cargo or "passanger" for passanger) of the train'
    type = gets.chomp

    carriage = Carriage.new
    if type == "cargo"
      train = CargoTrain.new(number, type, [])
      carriage = CargoCarriage.new
    elsif type == "passanger"
      train = PassangerTrain.new(number, type, [])
      carriage = PassangerCarriage.new
    else
      train = Train.new(number, type, [])
    end

    puts "Input count of carriages"
    carriages_count = gets.chomp.to_i

    carriages_count.times { train.add_carriage(carriage) }

    trains << train
    puts "Train with number #{number}, type #{type} has been created with #{carriages_count} carriages"
  elsif input == "add_carriage"
    puts "Your trains:"
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    index = gets.chomp.to_i

    if trains[index].nil?
      puts "Wrong index"
    else
      carriage = Carriage.new
      if trains[index].type == "cargo"
        carriage = CargoCarriage.new
      elsif trains[index].type == "passanger"
        carriage = PassangerCarriege.new
      end

      trains[index].add_carriage(carriage)
      puts "Carriage has been added"
    end
  elsif input == "delete_carriage"
    puts "Your trains:"
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    index = gets.chomp.to_i

    if trains[index].nil?
      puts "Wrong index"
    else
      trains[index].delete_carriage
      puts "Carriage has been deleted"
    end
  elsif input == "move_train"
    puts "Your trains:"
    puts trains

    puts "Choose train by index from 0 to #{trains.size - 1}"
    train_index = gets.chomp.to_i

    if trains[train_index].nil?
      puts "Wrong index"
    else
      puts "Your stations"
      puts stations

      puts "Chose station by index from 0 to #{stations.size - 1}"
      station_index = gets.chomp.to_i

      unless stations[station_index].nil?
        p route = Route.new(trains[train_index].current_station, stations[station_index])
        trains[train_index].route = route
        trains[train_index].go
        puts "Train went from #{route.from} to #{route.to}"
      end
    end
  elsif input == "stations"
    puts "Your stations"
    puts stations

    puts "Choose station by index from 0 to #{stations.size - 1}"
    index = gets.chomp.to_i

    puts "Station #{index}, Trains:"
    puts stations[index].trains
  else
    puts "I don't know this command: #{input}, but you can add it ;)"
  end
end
