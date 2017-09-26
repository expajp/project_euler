# Problem 46

def prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

catch(:find) do
  odd_com = 7
  loop do
    odd_com = odd_com + 2 
    next if prime?(odd_com)

    base = 1
    loop do
      maybe_prime = odd_com-2*base*base
      if maybe_prime <= 1
        puts "answer = #{odd_com}"
        throw(:find)
      elsif prime?(odd_com-2*base*base)
        puts "#{odd_com} = #{odd_com-2*base*base} + 2*#{base}^2"
        break
      end
      base = base + 1
    end
    # break if odd_com >= 33
  end
end
