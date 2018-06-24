# coding: utf-8
# Problem 86

=begin
下に示す直方体は寸法が6×5×3である. この直方体の1つの頂点Sにクモがいる. また反対の頂点Fにはハエがいる. SからFまでの壁に沿って直線移動する最短ルートは図に示す通りで, この長さは10である.

この最短ルートの候補は3本あるが, 最短のものがいつも整数長さとは限らない.

さて, M×M×M以下の寸法の直方体について, 最短ルートが整数である直方体の数を考える. M=100のとき, 条件を満たす直方体は2060個ある. このM=100は個数が2000を超える最小のMである. なお, M=99のときは1975個である.

100万個を超える最小のMを求めよ.
---
総当たりは実行速度が足りないので、原始ピタゴラス数に関する公式を適用する
原始ピタゴラス数とは、a, b, cのうち任意の2つが互いに素になるピタゴラス数
例えば、3, 4, 5
このとき、a = m^2-n^2, b = 2mn, c = m^2+n^2

また、最短経路となるのは、辺をmin<mid<maxとすると、
sqrt((min+mid)**2+max**2)
である

つまり、
maxが偶数の場合、
 max/2を素因数分解して、2値a, bの積にする（a<b）
 そこからmin+midの集合を求める
maxが奇数の場合、
 maxを素因数分解して、奇数a, bの積にする（a<b）
 a=m-n, b=m+nなので、和を取ると2m, 差を取ると2n
 これらの積を2で割ることで2mnを求め、min+midの集合を求める

とりあえずこれで実装し、網羅性があるかどうか調べる
=end

require 'prime'

def square?(n)
  (Math.sqrt(n).floor)**2 == n
end

def divisors(n)
  divisors = [1]
  primes = []
  n.prime_division.each do |prime|
    prime[1].times {primes << prime[0]}
  end

  1.upto(primes.size) do |i|
    primes.combination(i) do |prime|
      divisors << prime.inject{|a,b| a *= b}
    end
  end
  
  divisors.uniq!
  divisors.sort!
  return divisors
rescue ZeroDivisionError
  return
end

count = 0
max = 1
loop do
  max += 1
  next if max.prime?
  if max%2 == 0 # maxが偶数
    divisors(max/2).each do |n|
      m = max/(2*n)
      break if n >= m
      a = m**2 - n**2
      next if a > max*2
      p "max: #{max}, min+mid: #{a}, patterns: #{(a < max ? (a/2.0).ceil : (a/2.0).floor-(a-max)+1)}"
      count += (a < max ? (a/2.0).ceil : (a/2.0).floor-(a-max)+1)
    end
  else # maxが奇数
    divisors(max).each do |minus|
      plus = max/minus
      break if minus >= plus
      b = (plus+minus)*(plus-minus)/2
      next if b > max*2
      p "max: #{max}, min+mid: #{b}, patterns: #{(b < max ? (b/2.0).ceil : (b/2.0).floor-(b-max)+1)}"
      count += (b < max ? (b/2.0).ceil : (b/2.0).floor-(b-max)+1)
    end
  end
  p "max: #{max}, count: #{count}"
  break if count > 2000
end
