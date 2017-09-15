# Problem 47

def prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

def get_num_prime_factors(n)
  limit = (n/2).ceil
  return 0 if prime?(n)

  ret = []
  buf = n
  ret.push(2) if buf % 2 == 0
   
  3.step(limit, 2) do |p|
    next if !prime?(p)
    ret.push(p) if buf % p == 0
  end

  return ret
  
end

chain = 1
p_length = 0
i = 2
loop do
  if prime?(i)
    p_length = 1
    i = i + 1
    next
  end
  
  arr =  get_num_prime_factors(i)
  length = arr.size
  if length == p_length
    chain = chain + 1
    break if chain == 4 && length == 4
  else
    chain = 1
  end
  
  puts "#{i} #{arr}" if chain >= 2 && length == 4
  p_length = length
  i = i + 1
end

i.step(i-2, -1){|j| puts " #{j} #{get_num_prime_factors(j)}"}
