vowels = {
  a: 0,
  e: 0,
  i: 0,
  o: 0,
  u: 0,
  y: 0
}

current_index = 1
(:a..:z).each do |letter|
  vowels[letter] = current_index unless vowels[letter].nil?
  current_index += 1
end

puts vowels
