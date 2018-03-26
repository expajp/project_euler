# coding: utf-8
# Problem 66

=begin
次の形式の, 2次のディオファントス方程式を考えよう:

x^2 - Dy^2 = 1
たとえば D=13 のとき, x を最小にする解は 649^2 - 13×18^2 = 1 である.

D が平方数(square)のとき, 正整数のなかに解は存在しないと考えられる.

D = {2, 3, 5, 6, 7} に対して x を最小にする解は次のようになる:

3^2 - 2*2^2 = 1
2^2 - 3*1^2 = 1
9^2 - 5*4^2 = 1
5^2 - 6*2^2 = 1
8^2 - 7*3^2 = 1
したがって, D ≤ 7 に対して x を最小にする解を考えると, D=5 のとき x は最大である.

D ≤ 1000 に対する x を最小にする解で, x が最大になるような D の値を見つけよ.

x - d
 odd - odd  y = even
 odd - even y = any
even - odd  y = odd
even - even y nothing

xを順に増やしていくのは仕方ない
yを探索するコストをどうにか減らしたい
(x^2-1)/D = y^2
->yが整数で平方数ならそのyが正解
あっ……

=end

def square?(n)
  (Math.sqrt(n).floor.to_i)**2 == n
end

answer_x = 0
answer = 0

2.upto(1000) do |d|
  p "D=#{d}"
  next if square?(d)
  x = (d%2 == 0 ? 1 : 2)
  
  loop do
    quot = (x*x-1)/d
    mod = (x*x-1)%d
    p "x = #{x}, quot = #{quot}, mod = #{mod}" if mod == 0
    if mod == 0 && square?(quot)
      if answer_x < x
        answer_x = x
        answer = d
        p "D = #{d}, x = #{x}, y = #{Math.sqrt(quot).to_i}"
      end
      break
    else
      x += (d%2 == 0 ? 2 : 1)
    end
  end
end
p "asnwer = #{answer}, answer_x = #{answer_x}"
