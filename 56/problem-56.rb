# coding: utf-8
# Problem 56

=begin
Googol (10^100)は非常に大きな数である: 1の後に0が100個続く. 100^100は想像を絶する. 1の後に0が200回続く. その大きさにも関わらず, 両者とも数字和 ( 桁の和 ) は1である.

a, b < 100 について自然数 a^b を考える. 数字和の最大値を答えよ.
=end

def sum_of_digits(num)
  num.to_s.split('').map(&:to_i).inject(&:+)
end

answer = 0
1.upto(100) do |a|
  1.upto(100) do |b|
    buf = sum_of_digits(a**b)
    answer = (answer < buf ? buf : answer)
  end
end

p answer
