# coding: utf-8
# Problem 69

=begin
オイラーのトーティエント関数, φ(n) [時々ファイ関数とも呼ばれる]は, n と互いに素な n 未満の数の数を定める. たとえば, 1, 2, 4, 5, 7, そして8はみな9未満で9と互いに素であり, φ(9)=6.

n	互いに素な数	φ(n)	n/φ(n)
2	1	1	2
3	1,2	2	1.5
4	1,3	2	2
5	1,2,3,4	4	1.25
6	1,5	2	3
7	1,2,3,4,5,6	6	1.1666...
8	1,3,5,7	4	2
9	1,2,4,5,7,8	6	1.5
10	1,3,7,9	4	2.5
n ≤ 10 では n/φ(n) の最大値は n=6 であることがわかる.

n ≤ 1,000,000で n/φ(n) が最大となる値を見つけよ.
=end

def prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

def primes(max)
  return [] if max < 2
  ret = [2]
  3.step(Math.sqrt(max).floor, 2) do |i|
    ret.push(i) if prime?(i)
  end
  return ret
end

def prime_factors(n)
  ret = []
  @primes.each do |p|
    while n%p == 0 do
      n = n/p
      ret.push(p)
    end
  end
  ret.uniq
end

def totient(n)
  return n-1 if prime?(n) # [*1..n-1] if prime?(n)

  ret = n
  pfs = prime_factors(n)
  pfs.each do |pf|
    ret = ret*(pf-1)/pf 
  end
  ret
end

def func(n)
  n.to_f/totient(n)
end

max = 1000000
@primes = primes(max)

answer = 0
2.upto(max) do |i|
  f = func(i)
  if answer < f
    answer = f
    p "#{i} #{f}"
  end
end
p answer
