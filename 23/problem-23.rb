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
abundant_two_digits = []
abundant_three_digits = []

28123.times do |n|
  if func_d(n+1) > n+1
    abundant.push(n+1)
  end
end

abundant = abundant.sort
abundant_two_digits = abundant.select{ |i| i < 100 }
abundant_three_digits = abundant.select{ |i| i < 1000 && i >= 100 }
#puts abundant_two_digits.to_s

answer = 0
28110.times do |n|
  # 小さすぎる数と12,20,42の倍数はカット
  # 2, 3, 5, 7を素因数として含むため数が多くなるはず
  if n+1 < 30
    answer = answer + (n+1)
    next
  elsif (n+1) % 12 == 0 || (n+1) % 20 == 0 || (n+1) % 42 == 0
    next
  end

  # 100が過剰数で、過剰数の倍数は過剰数
  # つまり、下n桁（n>=2）が過剰数なら、その数は過剰数の和で表せる
  if abundant_two_digits.include?((n+1)%100)
    next
  elsif abundant_three_digits.include?((n+1)%1000)
    next
  end

  abundant_buf = abundant.select { |i| i <= (n+1)+12 }
  abundant_buf.reverse.each do |a| # 過剰数の大きい順にループ
    if abundant_buf.include?(n+1-a) # (n+1)-aが過剰数ならば、n+1は過剰数の和
      break
    elsif (n+1) % a == 0
      break
    elsif (n+1)/2 >= a
      answer = answer + (n+1)
      break
    end
  end

end

puts answer.to_s
