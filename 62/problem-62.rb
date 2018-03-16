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
def set_cubes(max_digits)
  n = 1
  loop do
    cube = n**3
    break if cube.to_s.length > max_digits
    @cube.push(cube)
    n += 1
  end
end

def cube?(n)
  @cube.include?(n)
end

def get_permutation(a)
  return [] if a.nil? || a.length == 0
  return [a] if a.length == 1
  return [a, a.reverse] if a.length == 2
  a.each do |v|
    ret = []
    arg = a.dup
    arg.delete_at(arg.find_index(v))
    get_permutation(arg).each do |b|
      (b.length+1).times { |i| ret.push(b.dup.insert(i, v))}
    end
    return ret.uniq
  end
end

def permutation_numbers(n)
  arr = n.to_s.split('')
  arr = get_permutation(arr)
  arr.select{ |a| a[0] != "0" }.map{ |a| a.inject(:+).to_i }
end

# p get_permutation([1,2,3])
set_cubes(10)
n = 345
loop do
  cube = n**3
  if !@cube.include?(cube)
    n += 1
    next
  end
  break if cube > @cube.max
  perm = permutation_numbers(cube).select{ |i| cube?(i) }
  p "n = #{n}, n^3 = #{cube}, count = #{perm.count}" if perm.count > 1
  break if perm.count == 5
  perm.each{ |i| @cube.delete(i) }
  n += 1
end
