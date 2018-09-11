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

product(1, inf){1-x^n} = sum(-inf, inf){ (-1)^n*x^(n(3n-1)/2) }

nの偶数個への分割をP0(n), 奇数個への分割をP1(n)とすると、

P0(n)-P1(n) = (-1)^k ( if n = (3k pm 1)/2 )\\ 0 (otherwise)

また、|x| < 1とみなして無限級数を考えると、
1+x+x^2+... = 1/(1-x)
なので、これを使って分配関数の母関数を変換し、
さらにオイラーの五角数定理を使うと

G(x)(1-x-x^2+x^5+x^7+x^12-...) = 1
G(x)(product(1, inf){1-x^n}) = 1
G(x) = product(1, inf){1-x^n}^(-1)
p(0)+p(1)x+p(2)x^2+... = product(1, inf){1-x^n}^(-1)

恒等式として解くと
p(n) = p(n-1) + p(n-2) + p(n-5) + ...

こちらに日本語で詳しい解説が載っている
http://d.hatena.ne.jp/inamori/20121216/p1

=end

def pentagonal_under(n)
  ret = []
  i = 1
  loop do
    break if (negative = i*(3*i-1)/2) >= n
    ret << negative
    break if (positive = i*(3*i+1)/2) >= n
    ret << positive    
    i += 1
  end
  ret
end

n = 2
answer = 0
p = [1, 1]
pentagonal = pentagonal_under(100000)
loop do
  p[n] = 0
  pentagonal.each_with_index do |penta, i|
    break if n-penta < 0
    sign = (i%4 <= 1 ? 1 : -1)
    # p "penta: #{penta}, i: #{i}, sign: #{sign}, p[n-penta]: #{p[n-penta]}"
    p[n] += sign*p[n-penta]
  end
  p[n] = p[n] % 1000000
  # p "p[#{n}] % 1000000 = #{p[n]}"
  break if p[n] == 0
  n += 1
  break if n > pentagonal.max
end
p "answer = #{n}"
