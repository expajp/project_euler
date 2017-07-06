# problem 14

def collaz_sequence(n, count)
  if n == 1
    return count+1
  elsif n.odd?
    return collaz_sequence(3*n.to_i+1, count+1)
  else
    return collaz_sequence(n.to_i/2, count+1)
  end
end

length = [0, 1]
2.step(1000000, 1) { |n|
  length[n] = collaz_sequence(n, 0)
}
puts length.max
puts length.index(length.max).to_s
