# coding: utf-8
# Problem 90

=begin
立方体の6面それぞれに異なる数字(0から9)が書かれている;2番目の立方体も同様になっている. 異なる位置に2つの立方体を隣り合わせることで様々な2桁の数を作ることができる.

例えば, 平方数である64も作ることができる:

p_090.gif
事実, 両方の立方体の数字を注意深く選ぶと100以下のすべての平方数を示すことが可能である:01, 04, 09, 16, 25, 36, 49, 64, そして 81.

例えば, これを実現する一つの方法としては {0, 5, 6, 7, 8, 9} を一方の立方体に, そして {1, 2, 3, 4, 8, 9} を他方の立方体に配置すればよい.

しかし, 6と9を逆さまに回転することを許すと {0, 5, 6, 7, 8, 9} と {1, 2, 3, 4, 6, 7} のような配列で9つすべての平方数を示す事ができる; そうでなければ09を得ることができない.

順番ではなくそれぞれの立方体の数字に着目して配列を区別する.

{1, 2, 3, 4, 5, 6} は {3, 6, 4, 1, 2, 5} と同じものとし
{1, 2, 3, 4, 5, 6} は {1, 2, 3, 4, 5, 9} と異なるものとする.

しかし6と9を逆さにすることを許すために, 最後の例で区別された両方の配列のかわりに, {1, 2, 3, 4, 5, 6, 9} という(要素数が７つに)拡張された配列を使用して2桁の数をつくることにする.

すべての平方数を表示し得る2つの立方体の異なる配列の組はいくつあるか.
=end

patterns = [*0..8].combination(6).to_a.map do |a|
  a << 9 if a.include?(6)
  a
end.combination(2).to_a

squares = [*1..9].map{ |i| i**2 }
count = 0
patterns.each do |combi|
  check = squares.map do |sq|
    if sq < 10
      (combi[0].include?(sq) && combi[1].include?(0)) ||
        (combi[0].include?(0) && combi[1].include?(sq))
    else
      (combi[0].include?(sq/10) && combi[1].include?(sq%10)) ||
        (combi[0].include?(sq%10) && combi[1].include?(sq/10))
    end
  end
  count += 1 if check
end
p count
