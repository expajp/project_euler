# coding: utf-8
# Problem 78

=begin
n 枚のコインを異なった方法で山に分ける場合の数を p(n) と表わす. 例えば, 5枚のコインを山に分ける異なったやり方は７通りなので p(5)=7 となる.

OOOOO

OOOO   O

OOO   OO

OOO   O   O

OO   OO   O

OO   O   O   O

O   O   O   O   O

p(n) が100万で割り切れる場合に最小となる n を求めよ.

---
総当りは無理、桁が大きくなりすぎていて限界が来る

https://en.wikipedia.org/wiki/Partition_(number_theory)

どうやら、分配関数（Partition function）を利用するようだ
日本語には整数に関するこの単語のページはない

分配関数を陽的に求める方法はここにある
http://mathworld.wolfram.com/PartitionFunctionP.html

これを実装する方針で進めればよい
結局、末尾6桁が0であればよいので、それより上を切っては足しを繰り返せればよい
つまり、必要なのは陽的に求める式から漸化式を導くことである

---
オイラーの五角数定理から、分割関数の漸化式が導かれる

product(0, inf){1-x^n)} = sum(-inf, inf){ (-1)^n*x^(n(3n-1)/2) }

nの偶数個への分割をP0(n), 奇数個への分割をP1(n)とすると、

P0(n)-P1(n) = (-1)^k ( if n = (3k pm 1)/2 )\\ 0 (otherwise)


=end

@gpfnah = []

# get patterns from n and h
def gpfnah(n, h)
  return @gpfnah[n][h] unless @gpfnah[n].nil? || @gpfnah[n][h].nil?
  return 1 if h == 1
  @gpfnah[n] = [] if @gpfnah[n].nil?
  @gpfnah[n][h] = [*1..n/h].map{ |i| [*1..h-1].map{ |j| gpfnah(n-h*i, h-j) }.sum }.sum
end

def piles(n)
  1+[*1..n-1].map{ |i| gpfnah(n, n-i)}.sum
end

n = 5
loop do
  pile = piles(n)
  n += 1
  next if pile < 1000000
  next if pile % 100 != 0
  p "pile = #{pile}, n = #{n-1}"
  next if pile % 10000 != 0
  next if pile % 1000000 != 0
  break
end
p "pile = #{pile}, n = #{n-1}"

