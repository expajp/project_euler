# coding: utf-8
# Problem 82

=begin
注: この問題はProblem 81よりも挑戦しがいがあるだろう.

下記の5次の正方行列で, 一番左の行の任意のセルから開始し一番右の行の任意のセルで終わる道を探索する. ただし上下右にのみ移動できるものとする. 一番小さなパスは下で赤の太字で示されたものである. このときの合計は994になる.

131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331
今, 31Kのテキストファイルmatrix.txtには80×80の行列が書かれている. 一番左の行から一番右の行へ移動する際の一番小さなパスの和を求めよ.

---
スタートとゴールは任意
上下に自由に進めるが、右にしか進めない
来た道は戻れないので、ある列について上を選んだら上だけ、下を選んだら下だけ
ということは、ある列について80通り（どこで右に進むか）の進路がある
スタートを固定して、幅優先探索で進めていく
同じ行をずーっと進むやつを基準にして枝刈りをしていく（コストがそれを上回ったら探索中止）
右端にたどり着くパターンを集め、最小のものを取る
これを各スタートについて繰り返し、さらに最小値を取ることで答えにたどり着く
計算量がやばかったらそのとき考える
=end

matrix = []
=begin
matrix = [
  [131, 673, 234, 103, 18],
  [201, 96, 342, 965, 150],
  [630, 803, 746, 422, 111],
  [537, 699, 497, 121, 956],
  [805, 732, 524, 37, 331]
]
=end

File.open("matrix.txt") do |f|
  f.each_line{ |line| matrix << line.split(',').map(&:to_i) }
end

# 処理の高速化のため、転置する
matrix = matrix.transpose

answers = []

matrix.length.times do |start|
  # start = 1

  # pathはstartからの最短距離を表す
  path = Marshal.load(Marshal.dump(matrix))
  # p path
  # p ''

  path.each_with_index do |row, i|
    if i == 0
      # 1行目はstartから上下移動した距離を格納
      path[i] = row.map.with_index do |elm, j|
        elm = (j < start ? row[j..start].sum : row[start..j].sum)
      end
    else
      # 2行目以降
      # まず、左から移動してきた距離を返す
      path[i] = row.map.with_index do |elm, j|
        elm += path[i-1][j]
      end
      
      # 左から移動してきた距離よりも、上や下から来たほうが速い場合は修正する
      # 理論上はすべて調べなくてはならない
      (path[i].length-1-start).times do
        buf = path[i].dup
        path[i].each.with_index do |elm, j|
          if j != 0 && elm > buf[j-1] + row[j]
            path[i][j] = buf[j-1] + row[j]
            # p "#{elm} -> #{path[i][j]}"
          end
        end
        path[i].each.with_index do |elm, j|
          if j != path[i].length-1 && elm > buf[j+1] + row[j]
            path[i][j] = buf[j+1] + row[j]
            # p "#{elm} -> #{path[i][j]}"
          end
        end
      end
      
    end
    # p path
  end
  answers <<  path[path.length-1].min
  # p answers.length
end
p answers
p answers.min
