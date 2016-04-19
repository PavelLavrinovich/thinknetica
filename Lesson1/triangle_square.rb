puts "Введите основание"
base = gets.chomp

puts "Введите высоту"
height = gets.chomp

square = height.to_i * base.to_i / 2
puts "Площадь треугольника равна #{square}"
