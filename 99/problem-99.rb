# coding: utf-8
# Problem 99

=begin
指数の形で表される2つの数, 例えば 2^11 と 3^7, の大小を調べることは難しくはない. 電卓を使えば, 211 = 2048 < 37 = 2187 であることが確かめられる.

しかし, 632382^518061 > 519432^525806 を確認することは非常に難しい (両者ともに300万桁以上になる).

各行に1組が書かれている1000個の組を含んだ22Kのテキストファイル base_exp.txt から, 最大の数が書かれている行の番号を求めよ.

注: ファイル中の最初の二行は上の例である.
=end

max = 0
max_line = 0
File.open("base_exp.txt") do |f|
  f.each_line.with_index do |l, i|
    val = l.gsub(/\n/, '').split(',').map(&:to_i)
    num = Math.log10(val[0])*val[1]
    if max < num
      max_line = i+1
      max = num
    end
  end
end
p max_line

