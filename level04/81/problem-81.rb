# coding: utf-8
# Problem 81

=begin
下記の5次の正方行列で, 左上のセルから開始し右下のセルで終わるパスを探索する. ただし下方向と右方向にのみ移動できるものとする. 
通過したセルの和が最小となるパスは赤の太字で示されたもので, その値は2427である.

131	673	234	103	18
201	96	342	965	150
630	803	746	422	111
537	699	497	121	956
805	732	524	37	331
今, 31Kのテキストファイルmatrix.txt (右クリックして, 『名前をつけてリンク先を保存』)には80×80の行列が書かれている. 
同様に左上のセルから開始し右下のセルで終わり, かつ右方向と下方向にのみ移動するときの最小のパスの和を求めよ.
=end

matrix = []
File.open("matrix.txt") do |f|
  f.each_line{ |line| matrix << line.split(',').map(&:to_i) }
end
# p matrix

answer = []
matrix.each_with_index do |row, i|
  answer[i] = []
  if i == 0
    row.each_with_index do |elm, j|
      if j == 0
        answer[i][j] = matrix[i][j]
      else
        answer[i][j] = answer[i][j-1] + matrix[i][j]
      end
    end
  else
    row.each_with_index do |elm, j|
      if j == 0
        answer[i][j] = answer[i-1][j] + matrix[i][j]
      else
        answer[i][j] = [answer[i][j-1], answer[i-1][j]].min + matrix[i][j]
      end
    end
  end
end
p answer[-1][-1]
