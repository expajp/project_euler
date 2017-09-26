# Problem 36

def palindromic(str)
  return true if str == str.reverse
  return false
end

answer = 0
1.step(999999) do |i|
  if palindromic(i.to_s) && palindromic(i.to_s(2))
    answer = answer + i
  end
end

puts answer.to_s
