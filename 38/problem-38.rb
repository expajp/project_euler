# Problem 38

def pandigital(n)
  arr = []
  n.to_s.each_char{|c| arr.push(c)}
  arr = arr.sort
  
  numbers = ('1'..'9').to_a
  return true if arr == numbers
  return false
end

answer = 0

i = 1
loop do
  prod = i.to_s

  j = 1
  loop do
    j = j + 1
    prod = prod.to_s + (i * j).to_s
    # puts "#{i} #{j} #{prod}"
    
    prod_len = prod.length
    
    break if prod_len > 9
    next if prod_len < 9

    if prod_len == 9 && pandigital(prod)
      answer = (prod.to_i > answer.to_i ? prod.to_i : answer.to_i)
      puts "#{i} #{j} #{prod}"
    end
  end
  
  i = i + 1
  # break if i > 9
  break if i.to_s.length + (i*2).to_s.length > 9
end

puts answer.to_s
