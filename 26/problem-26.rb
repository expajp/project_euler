# -*- coding: utf-8 -*-
# Problem 26

require "bigdecimal"

def recurring_cycle(f)
  # 一度小数点を消して整数にすると先頭の0が消える
  str = f.to_s.delete('.').to_i.to_s

  cycle = 0
  catch(:detect) do
    1.step(str.length) do |len|
      0.step(str.length-1) do |start|
        if str.slice(start, len) == str.slice(start+len, len)
          puts (1/f).to_i.to_s + " " + str + " " + len.to_s
          cycle = len
          throw :detect
        end
      end
    end
  end
  return cycle
end

answer = [0, 0] # answer, length
bd_1 = BigDecimal("1")
2.step(99) do |n|
  bd_n = BigDecimal(n.to_s)
  cycle = recurring_cycle(bd_1.div(bd_n, 100))
  if cycle.to_i > answer[1].to_i
    puts n.to_s + " " + cycle.to_s
    answer = [n, cycle]
  end
end

puts answer[0]
