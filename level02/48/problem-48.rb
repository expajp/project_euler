# Problem 48

sum = 0
1.step(1000) do |i|
  sum = sum + i**i
end

puts sum.to_s.slice(sum.to_s.length-10, 10)
