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

puts circular(1234).to_s
