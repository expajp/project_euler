# coding: utf-8
# Problem 92

=begin
各桁の2乗を足し合わせて新たな数を作ることを, 同じ数が現れるまで繰り返す.

例えば

　　44 → 32 → 13 → 10 → 1 → 1
　　85 → 89 → 145 → 42 → 20 → 4 → 16 → 37 → 58 → 89

のような列である. どちらも1か89で無限ループに陥っている. 
驚くことに, どの数から始めても最終的に1か89に到達する.

では, 10,000,000より小さい数で89に到達する数はいくつあるか.
=end

map = [nil, 1]
max = 10_000_000

2.upto(max) do |n|
  val = n
  p val if n%100000 == 0
  loop do
    val = val.to_s.split('').map{ |c| (c.to_i)**2 }.sum
    val = map[val] unless map[val].nil?
    break if val == 1 || val == 89
  end
  map[n] = val
end
p map.select{ |i| i == 89 }.length
