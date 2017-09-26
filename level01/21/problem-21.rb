# Problem 21

def list_divisor(n)
  upper_limit = Math.sqrt(n).ceil
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

def check_amicable(n, list)
  if list.include?(n)
    return []
  else
    ret = []
    d_n = func_d(n)

    if(d_n != n && func_d(d_n) == n)
      ret.push(n)
      ret.push(d_n)
    end

    return ret
  end
end

list = []

9999.times do |n|
  amc = check_amicable(n+1, list)
  if amc.empty?
    next
  else
    amc.each{|i| list.push(i)}
  end
end

puts list.inject(:+).to_s
