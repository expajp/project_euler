# coding: utf-8
# Problem 95

=begin
ある数の真の約数とは, それ自身を除く約数すべてである. 例えば, 28 の真の約数は 1, 2, 4, 7, 14 である. これらの約数の和は 28 に等しいため, これを完全数と呼ぶ.

面白いことに, 220 の真の約数の和は 284 で, 284 の真の約数の和は 220 となっており, 二つの数が鎖をなしている. このため, 220 と 284 は友愛数と呼ばれる.

さらに長い鎖はあまり知られていないだろう. 例えば, 12496 から始めると, 5 つの数の鎖をなす.

12496 → 14288 → 15472 → 14536 → 14264 (→ 12496 → ...)
この鎖は出発点に戻っているため, 友愛鎖と呼ばれる.

いずれの要素も 1,000,000 を超えない最長の友愛鎖の最小のメンバーを求めよ.
=end

require 'prime'

# https://qiita.com/seinosuke/items/fde2e0471dcf937e5a09
class Integer
  def divisors
    n = self
    divisors = [1]
    primes = []
    Prime.prime_division(n).each do |prime|
      prime[1].times {primes << prime[0]}
    end

    1.upto(primes.size) do |i|
      primes.combination(i) do |prime|
        divisors << prime.inject{|a,b| a *= b}
      end
    end

    divisors.delete(n)
    divisors.uniq!
    divisors.sort!
    return divisors
  rescue ZeroDivisionError
    return
  end
end

amicable = [nil, false]

max = 1000000
answer_chain = []
2.upto(max) do |n|
  chain = [n]
  val = n
  loop do
    val = val.to_i.divisors.sum
    if val == n
      amicable[n] = true
      answer_chain = chain if chain.length > answer_chain.length
      p "n: #{n}, chain: #{chain}"
      break
    elsif !amicable[val].nil? || chain.include?(val) || val == 0 || val > max
      amicable[n] = false
      break
    end
    chain << val
  end
end
p answer_chain
p answer_chain.length
p answer_chain.min
