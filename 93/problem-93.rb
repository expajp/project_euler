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

def calc_a(p, ops)
  return nil if p.include?(0) && ops.map.with_index{ |op, i| op == '/' && p[i+1] == 0 }
  
  elm = p[0]
  denomi = 1
  ops.each_with_index do |op, i|
    if op == '*'
      elm *= p[i+1]
    elsif op == '/'
      denomi *= p[i+1]
    else
      elm = eval("#{elm}#{op}#{denomi}*#{p[i+1]}")
    end
  end
  return nil if elm%denomi != 0
  return elm/denomi
end

def calc_b(p, ops)
  return nil if p.include?(0) && ops.map.with_index{ |op, i| op == '/' && p[i+1] == 0 }

  elm_left = p[0]
  denomi_left = 1
  if ops[0] == '/'
    denomi_left *= p[1]
  else
    elm_left = eval("#{elm_left}#{ops[2]}#{p[1]}")
  end
 
  elm_right = p[2]
  denomi_right = 1
  if ops[2] == '/'
    denomi_right *= p[3]
  else
    elm_right = eval("#{elm_right}#{ops[2]}#{p[3]}")
  end

  elm = 0
  denomi = 1
  if ops[1] == '*'
    elm = elm_left*elm_right
    denomi = denomi_left*denomi_right
  elsif ops[1] == '/'
    elm = elm_left*denomi_right
    denomi = denomi_left*elm_right
  else
    elm = eval("#{elm_left}*#{denomi_right}#{ops[1]}#{elm_right}*#{denomi_left}")
    denomi = denomi_left*denomi_right
  end
  
  return nil if denomi == 0 || elm%denomi != 0
  return elm/denomi
end


operand = ['+', '-', '*', '/']
n = 0
answer = nil

[*0..9].repeated_combination(4) do |set|
  arr = []
  set.permutation(4).each do |p|
    operand.repeated_permutation(3) do |ops|
      a = calc_a(p, ops)
      arr << a unless a.nil?
      b = calc_b(p, ops)
      arr << b unless b.nil?
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
