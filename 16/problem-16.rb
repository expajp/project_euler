# Problem 16
value = 0
(2**1000).to_s.each_char{ |c| value += c.to_i }
puts value
