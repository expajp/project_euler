# coding: utf-8
# Problem 70

=begin
オイラーのトーティエント関数 φ(n) (ファイ関数とも呼ばれる) とは, n 未満の正の整数で n と互いに素なものの個数を表す. 例えば, 1, 2, 4, 5, 7, 8 は9未満で9と互いに素であるので, φ(9) = 6 となる. 
1 は全ての正の整数と互いに素であるとみなされる. よって φ(1) = 1 である.

面白いことに, φ(87109)=79180 であり, 87109は79180を置換したものとなっている.

1 < n < 107 で φ(n) が n を置換したものになっているもののうち, n/φ(n) が最小となる n を求めよ.
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
  ret
end

def permutation?(n, m)
  arr = n.to_s.split('').permutation(n.to_s.length).to_a.select{ |a| a[0] != 0 }.map{ |a| a.inject(:+).to_i }
  arr.include?(m)
end

max = 10**7
answer = max
combi_primes = primes(max).combination(2).to_a

combi_primes.each do |combi|
  pp = combi.inject(:*) # primes_product
  t = combi.inject{ |p, q| (p-1)*(q-1) }
  next unless permutation?(pp, t)
  f = pp/t.to_f
  if f < answer
    p "combi = #{combi}, pp = #{pp}, t = #{t}, f = #{f}"
    answer = pp
  end
end
p answer
