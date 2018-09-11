# coding: utf-8
# Problem 80

=begin
よく知られているように, 自然数の平方根が整数ではないならば, それは無理数である.

そのような平方根の10進展開(decimal expansion)は繰り返しを持たない無限小数になる.

2の平方根は, 1.41421356237309504880...,であり, その頭から100桁の数字を合計すると475になる.

初めの100個の自然数の平方根のうち, 無理数について, それぞれの頭から100桁の数字を足した数の総和を求めよ.
=end

require 'bigdecimal/math'

def square?(n)
  (Math.sqrt(n).floor)**2 == n
end

sum = 0
2.upto(99) do |i|
  next if square?(i)
  sum += BigMath::sqrt(BigDecimal.new(i), 90).to_s[2..-3][0..99].split('').map(&:to_i).inject(:+)
end
p sum
