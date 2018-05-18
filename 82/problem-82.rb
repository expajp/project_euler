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
=end

matrix = []
File.open("matrix.txt") do |f|
  f.each_line{ |line| matrix << line.split(',').map(&:to_i) }
end
# p matrix

routes =  [*0..79].repeated_permutation(2).to_a

routes.each do |route|
  start = route[0]
  goal = route[1]
  answer = Marshal.load(Marshal.dump(matrix))

  
end
