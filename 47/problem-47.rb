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
  loop do
    if buf % 2 == 0
      buf = buf.div(2)
      ret.push(2)
    else
      break
    end
  end

   
  3.step(limit, 2) do |p|
    next if !prime?(p)
    loop do
      if buf % p == 0
        buf = buf.div(p)
        ret.push(p)
      else
        break
      end      
    end
  end

  return ret.uniq
  
end

chain = 1
p_length = 0
i = 2
loop do
  length = get_num_prime_factors(i).size
  if length == p_length
    chain = chain + 1
    break if chain == 4 && length == 4
  else
    chain = 1
  end
  
  puts "#{i} #{get_num_prime_factors(i)}" if chain >= 2 && length == 4
  p_length = length
  i = i + 1
end

i.step(i-3, -1){|j| puts get_num_prime_factors(j).to_s}
