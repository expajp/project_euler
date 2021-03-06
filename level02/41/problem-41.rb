# Problem 41

def check_if_prime(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

def pandigital(n, digit)
  arr = []
  n.to_s.each_char{|c| arr.push(c)}

  arr = arr.sort
  numbers = ('1'..digit.to_s).to_a
  return true if arr == numbers
  return false
end

answer = 0

2.step(9) do |n|
  next if ('1'..n.to_s).inject(:+).to_i % 3 == 0
  (10**(n-1)+1).step(10**(n-1)*(n+1), 2) do |i|
    next if i.to_s.include?('0')
    next if !pandigital(i, n)
    next if !check_if_prime(i)
    puts i.to_s
    answer = i
  end
end

puts answer.to_s
