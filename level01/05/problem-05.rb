# coding: utf-8
# Problem 05

require 'prime'

def max_common_div(a, b)
  if a > b && b != 0
    max_common_div(a%b, b)
  elsif a < b && a != 0
    max_common_div(a, b%a)
  else
    return (a > b ? a : b)
  end
end

arr = [2520]
[*11..20].each do |n|
  prod = arr.inject(:*)
  mcd = max_common_div(prod, n)
  arr << n/mcd
end
p arr.inject(:*)
