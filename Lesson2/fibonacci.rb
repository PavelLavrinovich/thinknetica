def next_fibonacci(fibonacci_numbers)
  fibonacci_numbers[-1] + fibonacci_numbers[-2]
end

fibonacci_numbers = [1, 1]
current_fibonacci = next_fibonacci(fibonacci_numbers)

while current_fibonacci < 100
  fibonacci_numbers << current_fibonacci
  current_fibonacci = next_fibonacci(fibonacci_numbers)
end

puts fibonacci_numbers
