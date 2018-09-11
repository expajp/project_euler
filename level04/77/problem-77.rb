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

# get primes patterns
def gpp(n, h)
  return 0 if n == 1 || (n < h && n != 0)
  return 1 if n == 0 || (h == 2 && n%h == 0)
  # p "n:#{n} h:#{h}"
  ret = 0
  [*1..n/h].each do |q|
    primes_under(h-1).reverse.each do |i|
      ret += gpp(n-h*q, i)
      break if q == n/h && n-h*q == 0 # n%q == 0のケースは2度以上カウントしない
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
  primes_under(n-1).reverse.map{ |p| gpp(n, p) }.sum
end

i = 10
border = 5000
loop do
  patterns = prime_sums(i)
  p "i=#{i}, patterns = #{patterns}"
  break if patterns > border
  i += 1
end
p "answer = #{i}"
