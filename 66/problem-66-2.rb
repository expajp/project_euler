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

---
この方程式はペル方程式というらしく、Wikipediaに項目がある
底を連分数展開し、周期が決まったところで分数近似する
二乗して分子をx, 分母をyとおくとそれが最小解である

=end

def get_int_part_of_sqrt(n)
  Math.sqrt(n).floor.to_i  
end

def square?(n)
  (Math.sqrt(n).floor.to_i)**2 == n
end

def get_into_rational(root, int, elm)
  denomi = (root - int*int) / elm
  left = (get_int_part_of_sqrt(root)+int)/denomi
  new_int = (denomi*left  - int).abs

  return { "left": left, "denomi": denomi, "root": root, "int": new_int } # left, denomi, root, int
end

def get_str_hash(h)
  "#{h[:left]} + (sqrt(#{h[:root]})-#{h[:int]}) / #{h[:denomi]}"
end

def get_convergent(arr)
  answer = { "elm": 1, "denomi": 0 }
  int = arr.shift
  # p "int = #{int}, arr = #{arr}"
  rev = arr.reverse
  rev.each do |i|
    answer = { "elm": answer[:denomi]+answer[:elm]*i, "denomi": answer[:elm] }
    # p get_str_convergent(answer)
  end
  answer = { "elm": answer[:denomi]+answer[:elm]*int, "denomi": answer[:elm] }
  answer
end

def get_str_convergent(answer)
  "#{answer[:elm]}/#{answer[:denomi]}"
end

answer = 0
answer_x = 0
n = 2
loop do
  h = {"root": n, "int": get_int_part_of_sqrt(n), "denomi": 1}

  seed = { "elm": 0, "denomi": 0 }
  square_flg = false
  arr = [h[:int]]
  log = []
  loop do
    previous_h = h.dup
    h = get_into_rational(h[:root], h[:int], h[:denomi])
    if log.any?{ |log| log == h }
      square_flg = true if arr.length%2 == 0
      arr.delete_at(arr.length-1) if arr.length != 2
      # p "n=#{n}, #{arr}"
      seed = get_convergent(arr)
      break
    end
    arr.push(h[:left])
    log.push(h.dup)
  end

  x = seed[:elm]
  y = seed[:denomi]
  if square_flg
    x = x*x
    y = y*y
  end
  if answer_x < x
    answer_x = x
    answer = n
  end
  p "#{get_str_convergent(seed)}, square_flg = #{square_flg}"
    
  n += 1
  n += 1 if square?(n) # 次の数が平方数ならスキップ
  break if n > 1000
end

p "answer_x = #{answer_x}, answer = #{answer}"
