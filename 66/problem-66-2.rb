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

def square?(n)
  (Math.sqrt(n).floor.to_i)**2 == n
end

# 平方根の整数部分を取得
def get_int_part_of_sqrt(n)
  Math.sqrt(n).floor.to_i  
end

# 分母の有理化
def get_into_rational(root, int, elm)
  denomi = (root - int*int) / elm
  left = (get_int_part_of_sqrt(root)+int)/denomi
  new_int = (denomi*left  - int).abs

  return { "left": left, "denomi": denomi, "root": root, "int": new_int } # left, denomi, root, int
end

# 連分数展開の配列から近似分数を求める
def get_convergent(arr)
  int = arr.shift # 整数部分を分離

  # 最初の値は「逆数にしたら0になる数」とする
  answer = { "elm": 1, "denomi": 0 }

  # 末尾から、「ここまでの分数の逆数を取って足す」を繰り返す
  rev = arr.reverse
  rev.each do |i|
    answer = { "elm": answer[:denomi]+answer[:elm]*i, "denomi": answer[:elm] }
  end

  # 最後にまた逆数を取った上で整数部分を足す
  answer = { "elm": answer[:denomi]+answer[:elm]*int, "denomi": answer[:elm] }
  
  answer
end

# 分数の文字列表示
def get_str_convergent(answer)
  "#{answer[:elm]}/#{answer[:denomi]}"
end

# 連分数展開の過程の文字列表示
def get_str_hash(h)
  "#{h[:left]} + (sqrt(#{h[:root]})-#{h[:int]}) / #{h[:denomi]}"
end


answer = 0
answer_x = 0
n = 2
loop do
  # 初期値の設定
  # root: 平方根の元, int: 平方根の整数部分, denomi: 分母
  h = {"root": n, "int": get_int_part_of_sqrt(n), "denomi": 1}

  conv = nil
  square_flg = false
  arr = [h[:int]] # 連分数展開配列の最初の値を整数部分とする
  log = []
  loop do
    # 分母を有理化
    h = get_into_rational(h[:root], h[:int], h[:denomi])

    # 展開型が一致していたら1周期終わり
    if log.any?{ |log| log == h }
      
      # 周期が奇数なら答えを平方する必要あり
      # 配列には最初に整数部分を追加しているため、周期が奇数のとき配列長は偶数
      square_flg = true if arr.length%2 == 0

      # 周期1以外の場合は末尾の値を削除
      arr.delete_at(arr.length-1) if arr.length != 2

      # 平方根の近似分数を取得
      conv = get_convergent(arr)
      break
    end

    # 連分数展開の配列に整数部分を追加
    arr.push(h[:left])

    # 展開型の記録に追加
    log.push(h.dup)
  end

  # ペル方程式の解は近似分数の分母分子から求められる
  x = conv[:elm]
  y = conv[:denomi]

  # 連分数展開の周期が奇数の場合は平方する必要あり
  if square_flg
    x = x*x
    y = y*y
  end

  # ここまでのxの最大値を更新していたら答えを格納
  if answer_x < x
    answer_x = x
    answer = n
  end
  # p "#{get_str_convergent(conv)}" # デバッグ用
    
  n += 1
  n += 1 if square?(n) # 次の数が平方数ならスキップ
  break if n > 1000
end

p "answer_x = #{answer_x}, answer = #{answer}"
