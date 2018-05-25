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

def search_point(length, arr)
  u_idx_i = arr.map(&:min).index(length)
  u_idx_j = arr[u_idx_i].index(length)
  [u_idx_i, u_idx_j]
end

def movable_points(u, d)
  vs = []
  vs << [u[0]-1, u[1]] if u[0] != 0 # 左
  vs << [u[0]+1, u[1]] if u[0] != d[0].length-1 # 右
  vs << [u[0], u[1]-1] if u[1] != 0 # 上
  vs << [u[0], u[1]+1] if u[1] != d.length-1 # 下
  vs
end

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

d = Marshal.load(Marshal.dump(matrix)).map{ |row| row.map{ |j| j = 999999 } }
d[0][0] = matrix[0][0]

q = [*0..matrix.length-1].repeated_permutation(2).to_a
prev = []
matrix.length.times { |i| prev[i] = [] }

while q.flatten.length > 0 do
  # 最小である頂点uの座標をqから取り出す
  u_length = d.map(&:min).min
  u = search_point(u_length, d)
  q.delete(u)

  # uから移動可能な各点vを格納
  vs = movable_points(u, d)
  
  # 各点vについてeach
  vs.each do |v|
    # いまdに格納されている距離の情報が、d(u)+matrix(u->v)より大きければ入れ替え
    # prev(u)にvの座標を格納
  end
end
