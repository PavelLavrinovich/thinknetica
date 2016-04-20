puts "Как Вас зовут?"
name = gets.chomp

puts "Какой у Вас рост?"
height = gets.chomp.to_i

weight = height - 110
print "#{name}, "
puts weight < 0 ? "Ваш вес уже оптимальный" : "Ваш идеальный вес: #{weight}"
