# Problem 35

def circular(n)
  ret = []
  buf = n
  (n.to_s.length).times do |i|
    buf = rotate(buf)
    ret.push(buf)
  end
  return ret
end

def rotate(n)
  return n.to_s.slice(1, n.to_s.length-1) + n.to_s.slice(0, 1)
end

def check_if_prime(n)
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

answer = [2]
3.step(1000000, 2) do |i|
  next if !check_if_prime(i)
  if circular(i).inject(true) { |sum, j| sum = sum && check_if_prime(j.to_i) }
    answer.push(i)
  end
end

puts answer.to_s
puts answer.length
