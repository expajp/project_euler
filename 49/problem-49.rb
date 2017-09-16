# Problem 49

def prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

def permutation(arr)
  return [] if arr.length == 0
  
  ret = []
  arr.each do |c|
    arr_copy = arr.dup
    arr_copy.delete_at(arr_copy.find_index(c))
    if arr_copy.length == 0
      ret.push(c)
    else
      permutation(arr_copy).each{ |str| ret.push(c.to_s+str)}
    end
  end
  return ret.uniq
end

catch(:found) do 
  1001.step(9999) do |a_1|
    next if !prime?(a_1)
    d_max = ((9999-a_1)/2).floor
    digits = []
    a_1.to_s.each_char{|c| digits.push(c)}
    p = permutation(digits)
    1.step(d_max) do |d|
      a_2 = a_1 + d
      next if !p.include?(a_2.to_s)
      next if !prime?(a_2)

      a_3 = a_2 + d
      next if !p.include?(a_3.to_s)
      next if !prime?(a_3)
      puts [a_1, a_2, a_3].to_s
      puts "#{a_1}#{a_2}#{a_3}"
      throw(:found) if a_1 != 1487
    end  
  end
end

