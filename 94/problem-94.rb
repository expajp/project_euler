# coding: utf-8
# Problem 94

=begin
一辺の長さが整数の正三角形は面積が整数にならないことを示すのは簡単である. しかし, 5-5-6の辺を持つ殆ど正三角形に近い擬正三角形 (almost equilateral triangle) は面積が12で整数である.

以降, 二等辺三角形で, 3つめの辺の長さが他と1つしか違わないもの (5-5-6, 5-5-4等) を, 擬正三角形と呼ぶ.

さて, 周囲の長さが1,000,000,000以下の面積が整数になる擬正三角形を考え, その周囲の長さの総和を求めよ.
--
l = m^2+n^2
a = 2mn
b = m^2-n^2
を利用する(n < m)

aによりいずれか一方は必ず偶数なので、これは考慮する必要なし
bottomが奇数ならば(bottom/2)^2は(奇数)/4になる
ということは高さは(4の倍数-奇数)/4になる
分子が両方奇数なので、これの積は分子が奇数になり、整数にはならない
つまり、lは必ず奇数
lが奇数ということは、m,nは片方が偶数でもう片方が奇数
つまり、bも奇数
よって、
- bottom/2が奇数ならば、(l+bottom/2)/2が平方数かどうか調べる
- bottom/2が偶数ならば、l+aが平方数かどうか調べる
ことでパターンを尽くせる
もちろん、整数倍は考慮しなくてはならないので、
lとbottom/2は互いに素になるような数(=maximum common divisor)で割ってから調べる

奇数を総当たりしては処理量が多くなるので、m, nを総当たりする
n = 1のときm = sqrt(10)*10000 ~= 30000程度かつn, mの偶奇が異なるので、これは総当たり可能

整数倍はパターンを見つけたその場で*2, 3, 4...と計算し、周囲の長さが既定値を超えた時点で終了する
=end

def mcd(a, b)
  if a > b && b != 0
    mcd(a%b, b)
  elsif a < b && a != 0
    mcd(a, b%a)
  else
    return (a > b ? a : b)
  end
end

def square?(n)
  (Math.sqrt(n).floor.to_i)**2 == n
end

max = 1_000_000_000
sum = 0

1.upto(Math.sqrt(max).floor.to_i) do |n|
  p n
  (n+1).step(Math.sqrt(max).floor.to_i, 2) do |m|
    l = n*n + m*m
    even = (((l+1)/2)%2 == 0)
    [l-1, l+1].each do |bottom|
      a = 2*n*m
      b = m*m - n*n
      if even
        if square?(l+a)
          round = l*2+bottom
          i = 1
          loop do
            sum += round*i
            i += 1
            break if round*i > max
          end
        end
      else
        if square?((l+bottom/2)/2)
          round = l*2+bottom
          i = 1
          loop do
            sum += round*i
            i += 1
            break if round*i > max
          end
        end
      end
    end
  end
end
p sum
