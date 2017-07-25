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

inabundant = []

#28123
100.times do |n|
  if func_d(n+1) > n+1
    inabundant.push(n+1)
  end
end

puts inabundant.to_s
