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
  return arr  
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

catch(:first_search) do
  p = add_pentagonal(2001,1000,[])

  p.length.times do |k|
    (k+1).step(p.length-1) do |i|
      if pentagonal?(p[k]+p[i])
        puts "p_k = #{p[k]}, p_i = #{p[i]}"
        if pentagonal?(p[k]+p[i]+p[i])
          puts "p_j = #{p[k]+p[i]}"
          throw(:first_search)
        end
      end
    end
  end

end
