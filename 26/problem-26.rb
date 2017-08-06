# -*- coding: utf-8 -*-
# Problem 26

require "bigdecimal"

def recurring_cycle(n, f, max)
  # 一度小数点を消して整数にすると先頭の0が消える
  str = f.to_s.delete('.').to_i.to_s

  cycle = n
  
  catch(:detect) do
    n.step(max, -1) do |len|
      0.step((n/2).floor-1) do |start|
        if str.slice(start, len) == str.slice(start+len, len) && len < cycle
          cycle = len
          # break
          throw :detect
        end
      end
    end
  end

    puts n.to_s + " " + str + " " + cycle.to_s
    
    return cycle
end

answer = [0, 0] # answer, length
bd_1 = BigDecimal("1")
cycle = 1

2.step(49) do |n|
  bd_n = BigDecimal(n.to_s)
  cycle = recurring_cycle(n.to_i, bd_1.div(bd_n, 200), cycle.to_i)
  if cycle.to_i > answer[1].to_i
    puts n.to_s + " " + cycle.to_s
    answer = [n, cycle]
  end
end

puts answer[0]
