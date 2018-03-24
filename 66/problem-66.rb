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
=end

def square?(n)
  (Math.sqrt(n).floor.to_i)**2 == n
end

answer_x = 0
answer = 0

2.upto(1000) do |d|
  p "D=#{d}"
  next if square?(d)
  catch(:foo) do
    x = 1
    loop do
      y = x
      loop do
        f = x*x-d*y*y
        # p "x=#{x}, y=#{y}, f=#{f}"
        break if f > 1
        if f == 1
          if answer_x < x
            answer_x = x
            answer = d
          end
          p "D=#{d}, x=#{x}, y=#{y}"
          throw :foo
        end
        if f < -(x*x)
          y -= d
        else
          y -= 1
        end
        break if y < 1
      end   
      x += 1
    end
  end
end
