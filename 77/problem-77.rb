# coding: utf-8
# Problem 77

=begin
10は素数の和として5通りに表すことができる:

7 + 3
5 + 5
5 + 3 + 2
3 + 3 + 2 + 2
2 + 2 + 2 + 2 + 2

素数の和としての表し方が5000通り以上になる最初の数を求めよ.
=end

require 'prime'

@gpfnah = []

# get primes patterns
def gpp(n, h)
  return 0 if n == 1 || n < h
  p "n:#{n} h:#{h}"
  if n%h == 0
    p "count!"
    return 1
  end
  ret = 0
  [*1..n/h].each do |q|
    break if n-h*q == 0
    primes_under(h).reverse.each do |i|
      ret += gpp(n-h*q, i)
      break if (n-h*q)%i == 0
    end
  end
  ret
end

def primes_under(n)
  ret = []
  Prime.each(n) { |p| ret << p }
  ret
end

def prime_sums(n)
  primes_under(n).reverse.map{ |p| gpp(n, p) }.sum
end

i = 11
patterns = 0
loop do
  patterns = prime_sums(i)
  p "i=#{i}, patterns = #{patterns}"
  break if patterns > 4
  i += 1
end
p "answer = #{i}"
