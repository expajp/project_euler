# coding: utf-8
# Problem 44

=begin
最小値を考える場合、すべての組合せを調べなくてはならない
2つの五角数の差は広がっていく一方なので、ある「条件を満たすペア」が見つかれば、
それ自身かそれ以下の差を持つ五角数ペアが正解のはず
つまり、最初は「とりあえず一つ見つける」という泥臭い探索をしなくてはならない
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
  # nを順番に代入していって2mより大きくなった時点でストップ、
  # という原始的な方法でOK
  
end
  
pentagonal = add_pentagonal(1,10,[])

pentagonal.length.times do |i|
  (i+1).step(pentagonal.length-1) do |j|
    
  end
end

puts pentagonal.to_s
