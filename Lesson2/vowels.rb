vowels = {
  a: 0,
  e: 0,
  i: 0,
  o: 0,
  u: 0,
  y: 0
}

(:a..:z).each_with_index do |letter, index|
  vowels[letter] = index + 1 unless vowels[letter].nil?
end

puts vowels
