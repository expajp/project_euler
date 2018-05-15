# coding: utf-8
# Problem 65

=begin
2の平方根は無限連分数として書くことができる.

式.jpg
無限連分数である √2 = [1;(2)] と書くことができるが, (2) は2が無限に繰り返されることを示す. 同様に, √23 = [4;(1,3,1,8)].

平方根の部分的な連分数の数列から良い有理近似が得られることが分かる.√2の近似分数について考えよう.

式2.jpg
従って, √2の近似分数からなる数列の最初の10項は：

1, 3/2, 7/5, 17/12, 41/29, 99/70, 239/169, 577/408, 1393/985, 3363/2378, ...

もっとも驚くべきことに, 数学的に重要な定数,
e = [2; 1,2,1, 1,4,1, 1,6,1 , ... , 1,2k,1, ...].

e の近似分数からなる数列の最初の10項は：

2, 3, 8/3, 11/4, 19/7, 87/32, 106/39, 193/71, 1264/465, 1457/536, ...

10項目の近似分数の分子の桁を合計すると1+4+5+7=17である.

e についての連分数である近似分数の100項目の分子の桁の合計を求めよ.
=end

arr = [2]
answer_arr = []
99.times do |i|
  if i % 3 == 1
    arr.push(2*(i/3)+2)
  else
    arr.push(1)
  end

  answer = { "elm": 1, "denomi": 0 }
  rev = arr.reverse
  rev.each do |j|
    answer = { "elm": answer[:denomi]+answer[:elm]*j, "denomi": answer[:elm] }
  end
  answer_arr.push(answer)
  # p "#{answer[:elm]}/#{answer[:denomi]}"
end

p answer_arr.last[:elm].to_s.split('').map(&:to_i).sum
