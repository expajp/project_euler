# Problem 45

def pentagonal?(m)
  n = 1
  loop do
    y = 3*n*n-n
    return true if y == 2*m
    return false if y > 2*m
    n = n + 1
  end
  
end

def triangle?(m)
  n = 1
  loop do
    y = n*n+n
    return true if y == 2*m
    return false if y > 2*m
    n = n + 1
  end
  
end

def get_hexagonal(start, length)
  ret = []
  start.step(start+length) do |n|
    ret.push(n*(2*n-1))
  end
  return ret.sort
end

start = 144
answer = 0
h = get_hexagonal(start, 30000)

h.each do |h_x|
  next if !pentagonal?(h_x)
  puts h_x.to_s
  next if !triangle?(h_x)
  answer = h_x
  break
end

puts answer.to_s
