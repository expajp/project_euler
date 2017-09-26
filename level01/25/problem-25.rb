# Problem 25
zero = Array.new
1001.times do |i|
    zero[i] = 0
end

full_adder_a = zero.clone
full_adder_b = zero.clone
answer = zero.clone

full_adder_a[0] = 1
full_adder_b[0] = 1

n = 2
loop do
  1000.times do |i|
    buffer = full_adder_a[i].to_i + full_adder_b[i].to_i
    answer[i+1] = (answer[i].to_i+buffer.to_i).div(10)
    answer[i] = (answer[i].to_i+buffer.to_i) % 10
  end

  n = n + 1
  break if answer[999] > 0

  # b < a
  full_adder_b = full_adder_a.clone
  full_adder_a = answer.clone
  answer = zero.clone
end

puts n.to_s
