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

