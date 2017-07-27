# Problem 23

def list_divisor(n)
  upper_limit = Math.sqrt(n)
  list = [1]

  2.step(upper_limit, 1) do |i|
    if n % i == 0
      list.push(i)
      list.push(n/i)
    end
  end

  return list.uniq.sort
end

def func_d(n)
  return list_divisor(n).inject(:+)
end

# 過剰数を配列に格納
abundant = []
28123.times do |n|
  if func_d(n+1) > n+1
    abundant.push(n+1)
  end
end
abundant = abundant.sort
# puts abundant.to_s

answer = 0
28123.times do |n|
  # puts (n+1).to_s
  abundant.each do |a| # 過剰数の小さい順にループ
    if n+1 <= a # aよりn+1が小さくなれば、「2つの過剰数の和で表せる数」でない
      answer = answer + (n+1)
      break
    elsif abundant.include?(n+1-a) # (n+1)-aが過剰数ならば、n+1は過剰数の和
      break
    end
  end
end

puts answer.to_s
