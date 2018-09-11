# coding: utf-8
# Problem 94

=begin
一辺の長さが整数の正三角形は面積が整数にならないことを示すのは簡単である. しかし, 5-5-6の辺を持つ殆ど正三角形に近い擬正三角形 (almost equilateral triangle) は面積が12で整数である.

以降, 二等辺三角形で, 3つめの辺の長さが他と1つしか違わないもの (5-5-6, 5-5-4等) を, 擬正三角形と呼ぶ.

さて, 周囲の長さが1,000,000,000以下の面積が整数になる擬正三角形を考え, その周囲の長さの総和を求めよ.
--
l = m^2+n^2
a = 2mn
b = m^2-n^2
を利用する(n < m)

aによりいずれか一方は必ず偶数なので、これは考慮する必要なし
bottomが奇数ならば(bottom/2)^2は(奇数)/4になる
ということは高さは(4の倍数-奇数)/4になる
分子が両方奇数なので、これの積は分子が奇数になり、整数にはならない
つまり、条件をみたすときbottomは必ず偶数

bottomが偶数ということは、lは奇数
lが奇数ということは、m,nは片方が偶数でもう片方が奇数
つまり、bも奇数
よって、
- bottom/2が奇数ならばここがbになる
- bottom/2が偶数ならばここがaになる

また、条件を満たすパターンの整数倍は擬正三角形に絶対にならないので考慮しなくてよい

奇数を総当たりしては処理量が多くなるので、m, nを総当たりする
n = 1のときm = sqrt(10)*10000 ~= 30000程度かつn, mの偶奇が異なるので、これは総当たり可能
=end

max = 1_000_000_000
sum = 0
searched = []

1.upto(Math.sqrt(max).floor.to_i) do |n|
  p n
  (n+1).step(Math.sqrt(max).floor.to_i, 2) do |m|
    l = n*n + m*m
    next if 3*l-2 > max
    [l-1, l+1].each do |bottom|
      next if 3*l+2 > max
      if (bottom/2).odd?
        b = m*m - n*n
        searched.push l*2+bottom if bottom/2 == b
      else
        a = 2*n*m
        searched.push l*2+bottom if bottom/2 == a
      end      
    end
  end
end
p searched.uniq.sum
