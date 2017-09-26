# Problem 34

def factorial(n)
  return 0 if n < 0
  return 1 if n == 0 || n == 1 

  return n*factorial(n-1)
  
end

fac = Array.new
10.times{|i| fac[i] = factorial(i)}
# puts fac.to_s

answer = 0

3.step(factorial(9)*7) do |n|
  sum = 0
  n.to_s.each_char{|c| sum = sum + fac[c.to_i]}
  if n == sum
    puts "#{sum}"
    answer = answer + sum
  end
end

puts "#{answer}"
