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
primes = [
  Prime.each((max**(1/2.0)).floor.to_i).to_a,
  Prime.each((max**(1/3.0)).floor.to_i).to_a,
  Prime.each((max**(1/4.0)).floor.to_i).to_a
]
answers = []
primes[0].each do |sq|
  primes[1].each do |cb|
    primes[2].each do |biq|
      val = sq**2 + cb**3 + biq**4
      answers << val if val < max
    end
  end
end

p answers.uniq.length
