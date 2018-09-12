# coding: utf-8
# Problem 10

require 'prime'
gen = Prime::EratosthenesGenerator.new
sum = 0
loop do
  p = gen.next
  break if p > 2000000
  sum += p
end
p sum
