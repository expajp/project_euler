# coding: utf-8
# Problem 02

arr = [1, 2]
loop do
  n = arr[-2..-1].sum
  break if n > 4000000
  arr << n
end
p arr.select{ |n| n%2 == 0 }.sum
