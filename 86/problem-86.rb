# coding: utf-8
# Problem 86

=begin
下に示す直方体は寸法が6×5×3である. この直方体の1つの頂点Sにクモがいる. また反対の頂点Fにはハエがいる. SからFまでの壁に沿って直線移動する最短ルートは図に示す通りで, この長さは10である.

この最短ルートの候補は3本あるが, 最短のものがいつも整数長さとは限らない.

さて, M×M×M以下の寸法の直方体について, 最短ルートが整数である直方体の数を考える. M=100のとき, 条件を満たす直方体は2060個ある. このM=100は個数が2000を超える最小のMである. なお, M=99のときは1975個である.

100万個を超える最小のMを求めよ.
=end

def square?(n)
  (Math.sqrt(n).floor)**2 == n
end

m = 1
loop do
  count = 0
  1.upto(m) do |max|
    1.upto(max) do |mid|
      1.upto(mid) do |min|
        edges = [min, mid, max]
        if square?(edges.map{ |short| short**2+(edges.sum-short)**2 }.min)
          count += 1
        end
      end
    end
  end
  p "m: #{m}, count: #{count}"
  break if count > 2000
  m += 1
end

