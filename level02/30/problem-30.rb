# Problem 30

answer = 0

2.step((9**5)*6) do |n|
  sum_fifth_powers = 0
  n.to_s.each_char{|c| sum_fifth_powers = sum_fifth_powers + (c.to_i)**5 }
  # puts n.to_s if n.to_i == sum_fifth_powers.to_i
  answer = (n.to_i == sum_fifth_powers.to_i ? answer + n.to_i : answer)
end

puts answer.to_s
