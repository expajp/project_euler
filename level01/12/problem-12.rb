# coding: utf-8
# Problem 12

require 'prime'
def num_divisors(n)
  n.prime_division.map(&:last).map{ |n| n+1 }.inject(:*)  
end

n = 2
loop do
  tri = n*(n+1)/2
  break if num_divisors(tri) > 500
  n += 1
end
p n*(n+1)/2
