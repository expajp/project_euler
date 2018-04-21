# coding: utf-8
# Problem 75

=begin
ある長さの鉄線を折り曲げて3辺の長さが整数の直角三角形を作るとき, その方法が1通りしかないような最短の鉄線の長さは12cmである. 他にも沢山の例が挙げられる.

12 cm: (3,4,5)
24 cm: (6,8,10)
30 cm: (5,12,13)
36 cm: (9,12,15)
40 cm: (8,15,17)
48 cm: (12,16,20)

それとは対照的に, ある長さの鉄線 (例えば20cm) は3辺の長さが整数の直角三角形に折り曲げることができない. また2つ以上の折り曲げ方があるものもある. 2つ以上ある例としては, 120cmの長さの鉄線を用いた場合で, 3通りの折り曲げ方がある.

120 cm: (30,40,50), (20,48,52), (24,45,51)

Lを鉄線の長さとする. 直角三角形を作るときに1通りの折り曲げ方しか存在しないような L ≤ 1,500,000 の総数を答えよ.

注: この問題は最近変更されました. あなたが正しいパラメータを使っているか確認してください.
=end

def hcf(n,m)
  # n < mを保障
  if m < n
    buf = n
    n = m
    m = buf
  end
  return n if m%n == 0
  hcf(m%n, n)
end

l_arr = []

max = 1500000
2.upto(Math.sqrt(max/2).floor) do |m|
  (m%2+1).step(m-1, 2) do |n|
    next if hcf(n, m) != 1
    l = 2*m*(m+n)
    break if l >= max || l_arr.include?(l)
    p "m = #{m}, n = #{n}, l = #{l}"
    if l == 12
      l_arr = [*1..(max/l).floor].map{ |i| i*l }
    elsif l == 30
      l_arr.push([*1..(max/l).floor].map{ |i| i*l }).flatten
    else
      [*1..(max/l).floor].map{ |i| i*l }.each { |j| l_arr.push(j) }
    end
  end
end
l_arr_uniq = l_arr.uniq
twice_or_more = (l_arr - l_arr_uniq).uniq
once = l_arr_uniq - twice_or_more

p "answer = #{once.length}"
