require "./station"
require "./train"
require "./cargo_train"
require "./passanger_train"
require "./carriage"
require "./cargo_carriage"
require "./passanger_carriage"

stations = []
trains = []

loop do
  puts ""
  puts 'Input "exit" for exit'
  puts 'Input "create_station" for create a station'
  puts 'Input "create_train for create a train'
  puts 'Input "add_carriage" for add a carriage'
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
      carriage = PassangerCarriege.new
    end

    puts "Input count of carriages"
    carriages_count = gets.chomp.to_i

    carriages_count.times { train.add_carriage(carriage) }

    trains << train
  elsif input == "add_carriage"

  else
    puts "I don't know this command: #{input}, but you can add it ;)"
  end
end
