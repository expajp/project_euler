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
  prod = i

  j = 2
  loop do
    prod = prod * i * j
    
    prod_len = prod.to_s.length
    break if prod_len > 9
    next if prod_len < 9
    if prod_len == 9 && pandigital(prod)
      answer = prod
      puts prod.to_s
      break
    end
  end
  
  i = i + 1
  break if i * i * 2 > 1000000000
end

puts answer.to_s
