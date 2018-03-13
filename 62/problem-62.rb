# coding: utf-8
# Problem 62

=begin
立方数 41063625 (3453) は, 桁の順番を入れ替えると2つの立方数になる: 56623104 (3843) と 66430125 (4053) である. 41063625は, 立方数になるような桁の置換をちょうど3つもつ最小の立方数である.

立方数になるような桁の置換をちょうど5つもつ最小の立方数を求めよ.


立方数かどうかの判定は、その数の３乗根に天井関数を適用
=end

=begin
def cube?(n)
  m = 1
  loop do
    return false if m**3 > n
    return true if m**3 == n
    m += 1
  end
end
=end
@cube = []
def set_cubes(max)
  1.upto(max){ |n| @cube.push(n**3) }
end

def cube?(n)
  @cube.include?(n)
end

def permutation_numbers(n)
  arr = n.to_s.split('').permutation(n.to_s.length).to_a.uniq
  arr.map{ |a| a.inject(:+).to_i }
end

set_cubes(1000)
n = 5
loop do
  p "n = #{n}, n^3 = #{n**3}"
  break if permutation_numbers(n**3).select{ |i| cube?(i) }.count == 5
  n += 1
end
