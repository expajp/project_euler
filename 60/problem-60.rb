# coding: utf-8
# Problem 60

=begin
素数3, 7, 109, 673は非凡な性質を持っている. 任意の2つの素数を任意の順で繋げると, また素数になっている. 例えば, 7と109を用いると, 7109と1097の両方が素数である. これら4つの素数の和は792である. これは, このような性質をもつ4つの素数の集合の和の中で最小である.

任意の2つの素数を繋げたときに別の素数が生成される, 5つの素数の集合の和の中で最小のものを求めよ.
=end

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

p prime_pair?(7, 109)
