# coding: utf-8
# Problem 72

=begin
nとdを正の整数として, 分数 n/d を考えよう. n<d かつ HCF(n,d)=1 のとき, 真既約分数と呼ぶ.

d ≤ 8について真既約分数を大きさ順に並べると, 以下を得る:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
この集合は21個の要素をもつことが分かる.

d ≤ 1,000,000について, 真既約分数の集合は何個の要素を持つか?
=end

require 'prime'

def totient(n)
  ret = n
  div = 1
  n.prime_division.each do |a|
    ret *= a[0]-1
    div *= a[0]
  end
  ret/div
end

max = 1000000
p [*2..max].map { |n| totient(n) }.inject(:+)
