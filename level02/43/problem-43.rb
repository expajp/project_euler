# Problem 43

@numbers = ('0'..'9').to_a

def pandigital?(n)
  arr = []
  n.to_s.each_char{|c| arr.push(c)}

  arr = arr.sort
  return true if arr == @numbers
  return false
end

def permutation(arr)
  return [] if arr.length == 0
  
  ret = []
  arr.each do |c|
    arr_copy = arr.dup
    arr_copy.delete(c)
    if arr_copy.length == 0
      ret.push(c)
    else
      permutation(arr_copy).each{ |str| ret.push(c.to_s+str)}
    end
  end
  return ret
end

puts "finished check all permutation of @numbers."

answer = 0
permutation(@numbers).each do |str|
  next if str.slice(0, 1) == "0"

  next if str.slice(1, 3).to_i % 2 != 0
  next if str.slice(2, 3).to_i % 3 != 0
  next if str.slice(3, 3).to_i % 5 != 0
  next if str.slice(4, 3).to_i % 7 != 0
  next if str.slice(5, 3).to_i % 11 != 0
  next if str.slice(6, 3).to_i % 13 != 0
  next if str.slice(7, 3).to_i % 17 != 0
  puts str
  answer = answer + str.to_i
end

puts answer.to_s


