# coding: utf-8
# Problem 88

=begin
少なくとも2つの自然数 {a1, a2, ... , ak} の集合の和かつ積として表せる自然数Nを積和数と呼ぶ：N = a1 + a2 + ... + ak = a1 × a2 × ... × ak.

例えば, 6 = 1 + 2 + 3 = 1 × 2 × 3.

ある集合の大きさ k に対して,この性質を持つ最小の N を最小積和数と呼ぼう. 集合の大きさ k = 2, 3, 4, 5, 6 に対する最小積和数は次のとおりである.

k=2: 4 = 2 × 2 = 2 + 2
k=3: 6 = 1 × 2 × 3 = 1 + 2 + 3
k=4: 8 = 1 × 1 × 2 × 4 = 1 + 1 + 2 + 4
k=5: 8 = 1 × 1 × 2 × 2 × 2 = 1 + 1 + 2 + 2 + 2
k=6: 12 = 1 × 1 × 1 × 1 × 2 × 6 = 1 + 1 + 1 + 1 + 2 + 6

したがって 2 ≤ k ≤ 6 に対して,全ての最小積和数の和は 4+6+8+12 = 30 である. 8 は和に一度だけカウントされていることに気をつけよう.

実際, 2 ≤ k ≤ 12 に対する最小積和数の完全な集合は {4, 6, 8, 12, 15, 16} なので,その和は 61 である.

2 ≤ k ≤ 12000 に対する全ての最小積和数の和は何か?
---

素数以外の数について、順番に
 素因数分解を行い
 和が元の数より小さい積での表示を求め
 和が足りない分を1で補う
という操作を繰り返す
項の数＋補った1の数がkになる
12000より大きい数はハネ、
数が12000-1個になった時点で処理をストップする
---
nを順番に調べる
あるnについて、素因数を格納した配列aを作る
aの長さをlとして、l以下の長さのcombinationを作る
各combinationについて、和と積(= n)の差を取ってkを求める
aの長さは高々知れているので、計算可能
=end

require 'prime'

def divisors(n)
  divisors = []
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

def products(n)
  return [[]] if n == 1
  ret = []
  divisors(n).each do |d|
    products(n/d).map{ |prd| [d, prd].flatten }.each{ |a| ret << a }    
  end
  ret.map(&:sort).uniq
end

arr = [nil, nil]
max = 12000
n = 3
loop do
  n += 1
  next if n.prime?

  pds = products(n)
  pds.each do |pd|
    k = pd.length+(n-pd.sum)
    if arr[k].nil? && k <= max
      arr[k] = n
      p pd
      p "arr[#{k}] = #{n}"
    end
  end
  break if arr.length == max+1 && !arr[2..max].include?(nil)
end

# p arr[2..max].uniq
p arr[2..max].uniq.sum

