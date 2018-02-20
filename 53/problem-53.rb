# coding: utf-8
# Problem 53

=begin
12345から3つ選ぶ選び方は10通りである.
123, 124, 125, 134, 135, 145, 234, 235, 245, 345.
組み合わせでは, 以下の記法を用いてこのことを表す: 5C3 = 10.

一般に, r ≤ n について nCr = n!/(r!(n-r)!) である. ここで, n! = n×(n−1)×...×3×2×1, 0! = 1 と階乗を定義する.
n = 23 になるまで, これらの値が100万を超えることはない: 23C10 = 1144066.
1 ≤ n ≤ 100 について, 100万を超える nCr は何通りあるか?
=end

def fact(n)
  [*1..n].inject(&:*)
end

def fact_top_m(n, m)
  [*(n-m+1)..n].inject(&:*)
end

def num_combination(n, r)
  fact_top_m(n, r)/fact(r)
end

n = 23
r = 10

answer = 0
23.upto(100) do |n|
  flg = false
  num = 0
  2.upto(n) do |r|
    num = num_combination(n, r)
    next if num <= 1000000
    break if num <= 1000000 && flg
    flg = true
    answer += 1
  end
end

p answer.to_s
