# coding: utf-8
# Problem 64

=begin
平方根は連分数の形で表したときに周期的であり, 以下の形で書ける:

√N = a0 + 1 / (a1 + 1 / (a2 + 1 / (a3 + ...)))

例えば, √23を考えよう.

√23 = 4 + √23 - 4 = 4 + 1 / (1 / (√23 - 4)) = 4 + 1 / (1 + (√23 - 3) / 7)

となる.

この操作を続けていくと,

√23 = 4 + 1 / (1 + 1 / (3 + 1 / (1 + 1 / (8 + ...))))

を得る.

操作を纏めると以下になる:

a0 = 4, 1/(√23-4) = (√23+4)/7 = 1 + (√23-3)/7
a1 = 1, 7/(√23-3) = 7(√23+3)/14 = 3 + (√23-3)/2
a2 = 3, 2/(√23-3) = 2(√23+3)/14 = 1 + (√23-4)/7
a3 = 1, 7/(√23-4) = 7(√23+4)/7 = 8 + (√23-4)
a4 = 8, 1/(√23-4) = (√23+4)/7 = 1 + (√23-3)/7
a5 = 1, 7/(√23-3) = 7(√23+3)/14 = 3 + (√23-3)/2
a6 = 3, 2/(√23-3) = 2(√23+3)/14 = 1 + (√23-4)/7
a7 = 1, 7/(√23-4) = 7(√23+4)/7 = 8 + (√23-4)
よって, この操作は繰り返しになることが分かる. 表記を簡潔にするために, √23 = [4;(1,3,1,8)]と表す. (1,3,1,8)のブロックは無限に繰り返される項を表している.

最初の10個の無理数である平方根を連分数で表すと以下になる.

√2=[1;(2)], period=1
√3=[1;(1,2)], period=2
√5=[2;(4)], period=1
√6=[2;(2,4)], period=2
√7=[2;(1,1,1,4)], period=4
√8=[2;(1,4)], period=2
√10=[3;(6)], period=1
√11=[3;(3,6)], period=2
√12= [3;(2,6)], period=2
√13=[3;(1,1,1,1,6)], period=5
N ≤ 13で奇数の周期をもつ平方根は丁度4つある.

N ≤ 10000 について奇数の周期をもつ平方根が何個あるか答えよ.

---
ある平方根について、小数部分は有理化された分数になる
この分数の逆数を取り、整数部分と小数部分に再度分離する
このときの整数部分が周期的な変化を見せる
周期が奇数になっている数を求める

再帰的な処理だが、周期を求める関係上ループで解いた方が都合が良い
周期を求めるには、1周+1回を求めるのが最低限

とりあえず、
・平方根の整数部分を求める
・分母の有理化
を行うトップレベルメソッドを実装し、周期的な変化を観測できるようにするのが最初の一歩
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


answer = 0
n = 2
loop do
  h = {"root": n, "int": get_int_part_of_sqrt(n), "denomi": 1}
  
  arr = []
  log = []
  loop do
    h = get_into_rational(h[:root], h[:int], h[:denomi])
    break if log.any?{ |log| log == h }
    arr.push(h[:left])
    log.push(h.dup)
  end
  
  # p "n = #{n}, arr = #{arr}"
  answer += 1 if arr.length % 2 == 1
  
  n += 1
  n += 1 if square?(n) # 次の数が平方数ならスキップ
  break if n > 10000
end

p "answer = #{answer}"
