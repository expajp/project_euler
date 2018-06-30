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

小さいnから順に、1を除く


=end

require 'prime'

divisors_arr = [nil, nil]

def divisors(n)
  return divisors_arr[n] unless divisors_arr[n].nil?
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

arr = [nil, nil]
max = 6
k = 1

n = 3
loop do
  n += 1
  break if n > 12
  next if n.prime?
  
  pd = Prime.prime_division(n)
  p_num = pd.map{ |a| a[1] }.sum
  p_all = []
  pd.each{ |a| a[1].times{ p_all << a[0] } }
  p "n: #{n}, pd: #{pd}, p_num: #{p_num}, p_all: #{p_all}"
  next if p_all.length < k
  p_all.combination(k).to_a.uniq.each do |c|
    sum = c.sum
    p "c: #{c}, sum: #{sum}"
    next if sum > n
    k =  k + (n-sum)
    arr[k] = n
  end
  p arr
end

p arr[2..max].uniq
