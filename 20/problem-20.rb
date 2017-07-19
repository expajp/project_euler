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
  
  if(tmp % 2 == 0 && count_fives > 0)
    count_fives = count_fives - 1
    tmp = tmp / 2
  end

  num = num * tmp
end

answer = 0
num.to_s.each_char{ |c| answer = answer + c.to_i }

puts answer
