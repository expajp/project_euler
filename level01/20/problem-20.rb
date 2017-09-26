num = 1
count_fives = 0

100.times do |n|
  tmp = n+1

  if(tmp % 25 == 0)
    count_fives = count_fives + 2
    tmp = tmp / 25
  elsif(tmp % 5 == 0)
    count_fives = count_fives + 1
    tmp = tmp / 5
  end
  
  if(tmp % 4 == 0 && count_fives > 1)
    count_fives = count_fives - 2
    tmp = tmp / 4
  elsif(tmp % 2 == 0 && count_fives > 0)
    count_fives = count_fives - 1
    tmp = tmp / 2
  end

  # puts (n+1).to_s + " " + tmp.to_s + " " + count_fives.to_s

  num = num * tmp
end

# puts num

answer = 0
num.to_s.each_char{ |c| answer = answer + c.to_i }

puts answer
