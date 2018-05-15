# coding: utf-8
# Problem 60

=begin
素数3, 7, 109, 673は非凡な性質を持っている. 任意の2つの素数を任意の順で繋げると, また素数になっている. 例えば, 7と109を用いると, 7109と1097の両方が素数である. これら4つの素数の和は792である. これは, このような性質をもつ4つの素数の集合の和の中で最小である.

任意の2つの素数を繋げたときに別の素数が生成される, 5つの素数の集合の和の中で最小のものを求めよ.
=end

def get_primes_under(n)
  arr = [*2..n]
  limit = Math.sqrt(n).floor
  p = 2
  used_p = []

  while(p < limit)
    arr = arr.reject{ |i| i != p && i % p == 0 }
    used_p.push(p)
    p = (arr - used_p).first
  end
  return arr
end

def prime?(n)
  return false if n <= 1 || (n != 2 && n % 2 == 0)
  return true if n == 2
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end
  return true
end

def prime_pair?(p1, p2)
  combi_1 = (p1.to_s + p2.to_s).to_i
  combi_2 = (p2.to_s + p1.to_s).to_i
  return false if !(prime?(combi_1) && prime?(combi_2))
  true
end

n = 10000
count = 0

primes = get_primes_under(n)
prime_pair_set = primes.combination(2).to_a.select { |a| prime_pair?(a[0], a[1]) }
p prime_pair_set.length

2.upto(4) do |size|
  next_set = []
  prime_pair_set.each do |combi|
    primes.each do |p|
      next if combi.include?(p)
      
      next_flg = false
      combi.each do |q|
        if !prime_pair?(p, q)
          next_flg = true
          break
        end
      end
      next if next_flg
      next if next_set.include?((combi+[p]).sort)
      next_set.push(combi.dup.push(p).sort)
      # p "combi = #{combi}, p = #{p}"
    end
  end
  p size
  # p next_set

  next_set_sum = []
  next_set.each{ |arr| next_set_sum.push(arr.inject(:+)) } # if size == 4
  p next_set_sum.min
  prime_pair_set = next_set
end
