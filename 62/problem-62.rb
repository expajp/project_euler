# coding: utf-8
# Problem 62

=begin
立方数 41063625 (3453) は, 桁の順番を入れ替えると2つの立方数になる: 56623104 (3843) と 66430125 (4053) である. 41063625は, 立方数になるような桁の置換をちょうど3つもつ最小の立方数である.

立方数になるような桁の置換をちょうど5つもつ最小の立方数を求めよ.


立方数かどうかの判定は、その数の３乗根に天井関数を適用
=end

@cube = []
def set_cubes(max_digits)
  n = 1
  loop do
    cube = n**3
    cube_len = cube.to_s.length
    break if cube_len > max_digits
    @cube[cube_len] ||= []
    @cube[cube_len].push(cube.to_s.split(''))
    n += 1
  end
end

set_cubes(12)
result = []
@cube.each_with_index do |digits, i|
  result[i] ||= {}
  next if @cube[i].nil?
  digits.each do |arr_n|
    n = arr_n.sort.inject(:+)
    if result[i].key?(n)
      result[i][n].push(arr_n.inject(:+))
    else
      result[i][n] = [arr_n.inject(:+)]
    end
  end
end

result.each do |h|
  next if h.nil?
  output =  h.select{ |k,v| v.length >= 5 }
  p output if output.any?
end
