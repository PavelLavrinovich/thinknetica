require "./station"
require "./route"
require "./train"
require "./carriage"

puts "Station has name"
p station = Station.new("Station1")
station2 = Station.new("Station2")
station3 = Station.new("Station3")

puts "Train has number, type and carriages"
p train1 = Train.new(42, "Type1", [Carriage.new, Carriage.new, Carriage.new])
p train2 = Train.new(43, "Type2", [Carriage.new, Carriage.new])

puts "Station can take one train"
station.take(train1)
station.take(train2)

puts "Station can display a list of all trains"
p station.trains

puts "Station can display trains with a type"
p station.trains_with_type("Type1")

puts "Station can send out a train"
station.send_out(train1)
p station.trains

puts 'Route has "from" and "to" stations'
p route = Route.new(station, station3)

puts "Route can add a new station between from and to"
route.add(station2)
p route

puts "Route can delete this station from the list"
route.delete(station2)
p route

puts "But route can not delete from and to stations"
route.delete(station3)
p route

puts "Route can display stations"
p route.stations

puts "Train can gain speed"
train1.gain_speed

puts "Train can display current speed"
puts train1.speed

puts "Train can stop"
train1.stop
puts train1.speed

puts "Train can display carriages"
puts train1.carriages

puts "Train can add/delete carriage"
carriage = Carriage.new
train1.add_carriage(carriage)
puts train1.carriages
train1.delete_carriage(carriage)
puts train1.carriages

puts "Train can not add/delete carriage if it is moving"
train1.gain_speed
train1.add_carriage(carriage)
puts train1.carriages
train1.delete_carriage(carriage)
puts train1.carriages

puts "Train can take a route"
p train1.route = route

puts "Train can move along a route"
train1.go
p train1.route.stations.last.trains

puts "Train can display current, next and previous station"
p train1.current_station
p train1.previous_station
p train1.next_station
