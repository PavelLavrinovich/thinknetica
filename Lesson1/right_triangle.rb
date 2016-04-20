sides = []

def pifagor(sides)
  sides.last**2 == sides[0]**2 + sides[1]**2
end

puts "Первая сторона"
sides << gets.chomp.to_i

puts "Вторая сторона"
sides << gets.chomp.to_i

puts "Третья сторона"
sides << gets.chomp.to_i

sides.sort!

if pifagor(sides)
  puts "Треугольник прямоугольный"
  puts "А ещё он равнобедренный" if sides[0] == sides[1]
else
  puts "Треугольник не является прямоугольным"
end
