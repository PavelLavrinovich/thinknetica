def leap(year)
  (year % 400).zero? || ((year % 4).zero? && !(year % 100).zero?)
end

months = {
  January: 31,
  February: 28,
  March: 31,
  April: 30,
  May: 31,
  June: 30,
  July: 31,
  August: 31,
  September: 30,
  October: 31,
  November: 30,
  December: 31
}

puts "Input number"
number = gets.chomp.to_i

puts "Input month"
month = gets.chomp.to_sym

puts "Input year"
year = gets.chomp.to_i

months[:February] += 1 if leap(year)

total_serial = 0
months.each do |current_month, current_number|
  if current_month == month
    total_serial += number
    break
  else
    total_serial += current_number
  end
end

puts total_serial
