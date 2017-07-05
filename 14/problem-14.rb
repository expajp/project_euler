# problem 14

def collaz_sequence(n, count)
  count += 1
  if n == 1
    puts "count: " + count.to_s
    return count
  elsif n.odd?
    collaz_sequence(n.to_i / 2, count)
  else
    collaz_sequence(3*n.to_i + 1, count)
  end
end

def check(n, max_length)
  length = collaz_sequence(n, 0)
  max_length = (max_length < length ? length : max_length)
end

max_length = 0
2.step(4, 1){ |n| max_length = check(n, max_length)}
puts max_length
