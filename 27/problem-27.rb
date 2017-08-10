# Problem 27

def func(a,b,n)
  a = a.to_i
  b = b.to_i
  n = n.to_i
  return n*n + a*n + b
end

def check_if_prime(n)
  return true if n == 2 
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

answer = 0

1.step(1000, 1) do |a|
  1.step(1000, 2) do |b|
  
    1.step do |n|
      if !check_if_prime(func(a,b,n))
        puts "n = " + n.to_s + ", a = " + a.to_s + ", b = " + b.to_s
        answer = (answer < n ? n : answer)
        break
      end
    end
    
  end
end

puts answer.to_s
