# coding: utf-8
# Problem 70

=begin
オイラーのトーティエント関数 φ(n) (ファイ関数とも呼ばれる) とは, n 未満の正の整数で n と互いに素なものの個数を表す. 例えば, 1, 2, 4, 5, 7, 8 は9未満で9と互いに素であるので, φ(9) = 6 となる. 
1 は全ての正の整数と互いに素であるとみなされる. よって φ(1) = 1 である.

面白いことに, φ(87109)=79180 であり, 87109は79180を置換したものとなっている.

1 < n < 107 で φ(n) が n を置換したものになっているもののうち, n/φ(n) が最小となる n を求めよ.
=end

require 'prime'

def primes(max)
  ret = []
  Prime.each(max/2){ |p| ret.push(p) }
  ret
end

def permutation?(n, m)
  return false if n.to_s.length != m.to_s.length
  arr = m.to_s.split('')
  n.to_s.split('').each do |d|
    idx = arr.index(d)
    return false if idx.nil?
    arr.delete_at(idx)
  end
  arr == []
end

max = 10**7
answer_f = max
answer = 1
primes = Prime::EratosthenesGenerator.new.take(Math.sqrt(max).floor/2)
combi_primes = primes.combination(2).to_a.select{ |a| a.inject(:*) < max }
# p combi_primes

combi_primes.each do |combi|
  pp = combi.inject(:*) # primes_product
  t = combi.inject{ |p, q| (p-1)*(q-1) }
  f = pp/t.to_f
  next if answer_f < f
  next unless permutation?(pp, t)
  if f < answer_f
    p "combi = #{combi}, pp = #{pp}, t = #{t}, f = #{f}"
    answer_f = f
    answer = pp
  end
end
p "answer=#{answer}, answer_f=#{answer_f}"

