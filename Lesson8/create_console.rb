require './input_console'
require './validation_error'
require './train.rb'
require './station.rb'
require './route.rb'
require './carriage.rb'
require './cargo_train'
require './passanger_train'
require './cargo_carriage'
require './passanger_carriage'

# Module for creations by console
module CreateConsole
  include InputConsole

  DEFAULT_CARRIAGE_CAPACITY = 100
  TRAIN_TYPES = { cargo: CargoTrain, passanger: PassangerTrain }.freeze
  CARRIAGE_TYPES = { cargo: CargoCarriage, passanger: PassangerCarriage }
                   .freeze

  protected

  def create_test_data
    5.times do |index|
      create_station!('Station')
      create_train!("CAR-#{index}#{index}", :cargo, 5)
      create_train!("PAS-#{index}#{index}", :passanger, 3)
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

  def create_train!(number, type, carriages_count)
    train = get_train(number, type)
    carriages_count.times { train.add_carriage(get_carriage(type)) }
    puts "Train has been created with a #{number} number"
  end

  def create_station!(name)
    Station.new(name)
    puts "Station with name: #{name} has been created."
  end

  def get_train(number, type)
    if TRAIN_TYPES[type]
      TRAIN_TYPES[type].new(number, [])
    else
      Train.new(number, type, [])
    end
  end

  def get_carriage(type, capacity = DEFAULT_CARRIAGE_CAPACITY)
    (CARRIAGE_TYPES[type] || Carriage).new(capacity)
  end

  def move_train!(train_index, station_index)
    train = Train.find(train_index)
    route = Route.new(train.current_station, Station.find(station_index))
    train.route = route
    train.go
    puts "Train went from #{route.from} to #{route.to}"
  end
end
