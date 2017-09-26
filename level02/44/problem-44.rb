# coding: utf-8
# Problem 44

=begin
p_j-p_i=p_kならば、p_i+p_k=p_jである。
このとき、p_i+p_jが五角数であればよい。
つまり、引き算はする必要がない。
=end

def add_pentagonal(start, length, arr)
  start.step(start+length) do |n|
    arr.push(n*(3*n-1)/2)
  end
  return arr.sort
end

def pentagonal?(m)
  # n*(3*n-1)/2 = m
  # 3n^2 - n - 2m = 0
  # この方程式が成立する整数nがあるかどうか？という問題を解かないとだめ
  # y = 3n^2 - n はn>=1において単調増加なので、
  # nを順番に代入していって2mより大きくなった時点でストップ
  n = 1
  loop do
    y = 3*n*n-n
    return true if y == 2*m
    return false if y > 2*m
    n = n + 1
  end
  
end

p = add_pentagonal(1, 2000, [])

catch(:found) do
  1.step(p.length) do |d|
    (d-1).step(1, -1) do |j|
      p_d = p[d-1]
      p_j = p[j-1]
      p_k = p_d.to_i + p_j.to_i
      next if !pentagonal?(p_k.to_i)
      puts "(d, j) = (#{d}, #{j}) p_j = #{p_j}, p_k = #{p_k}, D = #{p_d}"
      next if !pentagonal?(p_j.to_i+p_k.to_i)
      puts "S = #{p_j+p_k}"
      throw(:found)
    end
  end
end
