# coding: utf-8
# Problem 87

=begin
素数の2乗と素数の3乗と素数の4乗の和で表される最小の数は28である. 50未満のこのような数は丁度4つある.

28 = 2^2 + 2^3 + 2^4
33 = 3^2 + 2^3 + 2^4
49 = 5^2 + 2^3 + 2^4
47 = 2^2 + 3^3 + 2^4

では, 50,000,000未満の数で, 素数の2乗と素数の3乗と素数の4乗の和で表される数は何個あるか?
=end

require 'prime'

max = 50000000
primes = Prime.each(7071).to_a
answers = []
primes.repeated_permutation(3) do |a|
  val = a.map.with_index{ |n, i| n**(i+2) }.sum
  answers << val if val < max
end

p answers.uniq.length
