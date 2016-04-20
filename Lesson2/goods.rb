goods = {}

puts "Item name"
name = gets.chomp.to_sym

while name != :stop
  puts "Priсe"
  priсe = gets.chomp.to_f

  puts "Quantity"
  quantity = gets.chomp.to_f

  goods[name] = { priсe => quantity }

  puts "Item name"
  name = gets.chomp.to_sym
end

total = 0

goods.each do |item, amount|
  puts item

  item_total = 0
  amount.each do |current_price, current_quantity|
    puts "#{item} price: #{current_price}, quantity #{current_quantity}"
    item_total += current_price * current_quantity
  end
  puts "#{item} total amount: #{item_total}"

  total += item_total
end

puts "Total amount: #{total}"
