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

def max_common_div(a, b)
  if a > b && b != 0
    max_common_div(a%b, b)
  elsif a < b && a != 0
    max_common_div(a, b%a)
  else
    return (a > b ? a : b)
  end
end

def convert_arr_to_fraction(p)
  p.map{ |n| { elm: n, denomi: 1 } }
end

def ope(n, m, op)
  return nil if n.nil? || m.nil? || (m[:elm] == 0 && op == '/')
  ret = nil
  if op == '/'
    ret = { elm: n[:elm]*m[:denomi], denomi: n[:denomi]*m[:elm]  }
  elsif op == '*'
    ret = { elm: n[:elm]*m[:elm], denomi: n[:denomi]*m[:denomi]  }
  else
    ret = {
      elm: eval("#{n[:elm]}*#{m[:denomi]}#{op}#{m[:elm]}*#{n[:denomi]}"),
      denomi: n[:denomi]*m[:denomi]
    }
  end
  return ret
end

def calc(p, ops)
  p = convert_arr_to_fraction(p)
  ret = []
  
  ret << ope(ope(ope(p[0], p[1], ops[0]), p[2], ops[1]), p[3], ops[2])
  ret << ope(ope(p[0], ope(p[1], p[2], ops[1]), ops[0]), p[3], ops[2])
  
  ret << ope(ope(p[0], ope(p[1], p[2], ops[1]), ops[0]), p[3], ops[2])
  ret << ope(ope(p[0], p[1], ops[0]), ope(p[2], p[3], ops[2]), ops[1])

  ret << ope(p[0], ope(ope(p[1], p[2], ops[1]), p[3], ops[2]), ops[0])
  ret << ope(p[0], ope(p[1], ope(p[2], p[3], ops[2]), ops[1]), ops[0])

  ret << ope(ope(p[0], p[1], ops[0]), ope(p[2], p[3], ops[2]), ops[1])

  ret.map do |val|
    next if val.nil? || val[:elm] < 0 || val[:denomi] < 0
    mcd = (val[:denomi] == 1 ? 1 : max_common_div(val[:elm], val[:denomi]))
    { elm: val[:elm]/mcd, denomi: val[:denomi]/mcd }
  end.reject{ |val| val.nil? || val[:elm] < 0 || val[:denomi] < 0 || val[:denomi] != 1 }
end

operand = ['+', '-', '*', '/']
n = 0
answer = nil

=begin
p = convert_arr_to_fraction([1,2,5,8])
ops = ['/', '+', '*']
p calc(p, ops)
=end

# set = [1,2,5,8]
[*1..9].repeated_combination(4) do |set|
  arr = []
  set.permutation(4).each do |p|
    operand.repeated_permutation(3) do |ops|
      arr << calc(p, ops)
    end
  end
  arr = arr.flatten.map{ |val| val[:elm] }.select{ |i| i > 0 }

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
