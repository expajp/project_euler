# coding: utf-8
# Problem 83

=begin
注: この問題はProblem 81よりも非常に挑戦しがいがあるだろう.

下記の5次の正方行列で, 上下左右に移動し左上のセルから開始し右下のセルで終了する道を探索する. 一番小さな道は下で赤で示されており, このときの合計は2297になる.

131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331
今, 31Kのテキストファイルmatrix.txtには80×80の行列が書かれている. 上下左右に移動し左上のセルから開始し右下のセルで終了する道に沿った和の最小を求めよ.
---
上下左右に変が伸びているとして、ダイクストラ法を実装する
=end

matrix = []

matrix = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]
]

=begin
File.open("matrix.txt") do |f|
  f.each_line{ |line| matrix << line.split(',').map(&:to_i) }
end
=end

q = [*0..matrix.length-1].repeated_permutation(2).to_a
prev = []
matrix.length.times { |i| prev[i] = [] }
p q
p prev

while q.flatten.length > 0 do
end
