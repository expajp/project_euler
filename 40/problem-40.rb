# coding: utf-8
# Problem 40

=begin
d_1=1だから考えなくてよい
d_10, d_100,...d_1000000を調べて積を取る

普通に文字列に足していって、特定の値を取っていく
手でも解けそう
=end

str = ""

i = 0
loop do
  i = i + 1
  str = str + i.to_s
  break if str.length > 1000000
  puts i.to_s if i % 10000 == 0
end

answer =  str.slice(9, 1).to_i * str.slice(99, 1).to_i * str.slice(999, 1).to_i * str.slice(9999, 1).to_i * str.slice(99999, 1).to_i * str.slice(999999, 1).to_i

puts answer.to_s
