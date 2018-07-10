# coding: utf-8
# Problem 93

=begin
集合 {1, 2, 3, 4} の各数字をちょうど一度用い, また四則演算 (+, －, *, /) と括弧を使うことにより, 異なる正の整数を作ることができる.

例えば,

8 = (4 * (1 + 3)) / 2
14 = 4 * (3 + 1 / 2)
19 = 4 * (2 + 3) － 1
36 = 3 * 4 * (2 + 1)

12 + 34 のように数字をつなげることは許されないことに注意しよう.

集合 {1, 2, 3, 4} を使うと, 36 を最大とする 31 個の異なる数が得られる. 最初の表現できない数に会うまで, 1 から 28 の各数を得ることができる.

最長の連続した正の整数 1 から n の集合を得ることができる, 4 つの異なる数字 a < b < c < d を見つけよ. 答えを文字列 abcd として与えよ.
=end

n = 0
answer = nil

[*0..9].repeated_combination(4) do |set|
  arr = []
  set.permutation(4).each do |p|
    ['+', '-', '*', '/'].repeated_permutation(3) do |ops|
      exp = p[0].to_s
      ops.each_with_index do |op, i|
        exp = "#{exp}#{op}#{p[i+1]}"
        exp = "(#{exp})" if ['+', '-'].include?(op)
      end
      next unless exp.index('/0').nil?
      val = eval(exp)
      arr << val if val > 0
    end
  end

  arr.uniq.sort.each_cons(2) do |i, j|
    if i+1 != j
      if n < i
        n = i
        answer = set
        p "n=#{n}, answer=#{answer}"
      end
      break
    end
  end  
end

p "n=#{n}, answer=#{answer}"
