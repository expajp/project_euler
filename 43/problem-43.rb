# Problem 43

@numbers = ('0'..'9').to_a

def pandigital?(n)
  arr = []
  n.to_s.each_char{|c| arr.push(c)}

  arr = arr.sort
  return true if arr == @numbers
  return false
end

def permutation(str_arr, arr)
  return [] if arr.length < 1

  if arr.length == 1
    ret = []
    if str_arr.length == 0
      ret.push(arr[0])
    else
      str_arr.each {|str| ret.push(str+arr[0])}
    end
    return ret
    
  else
    arr.each do |c|
      ret = []
      if str_arr.length == 0
        ret.push(arr[0])
      else
        str_arr.each{ |str| ret.push(str+c.to_s)}
      end
      return permutation(ret, arr.delete(c))
    end
  end
end

puts permutation([], ('0'..'3').to_a).to_s
#puts permutation(["1","2"], ['0']).to_s

=begin
1.step(9) do |i|
  
  
end
=end

