# -*- coding: utf-8 -*-
# Problem 26

@until = 1000
require "bigdecimal"

def recurring_cycle(n, max_cycle)
  bd_1 = BigDecimal("1")
  f = bd_1.div(n, 2*@until)
  
  # 一度小数点を消して整数にすると先頭の0が消える
  str = f.to_s.delete('.').to_i.to_s
  if str.length < n
    return 1
  else
    cycle = n
  end
  
  # 循環している文字列を抽出
  catch(:first) do
    cycle.step(1, -1) do |len|
      # 枝刈り
      if cycle <= max_cycle
        return 1
      end

      # 1文字目からループするとは限らない
      0.step((len/2).floor) do |start|
        if str.slice(start, len) == str.slice(start+len, len)
          # 循環を検出したらそれをstrに格納して最小単位の検出に渡す
          cycle = len
          str = str.slice(start, len)
          throw :first
        end
      end
    end
  end
  
  # 最小単位の検出
  cycle.step(1, -1) do |len|
    # 枝刈り
    if cycle <= max_cycle
      return 1
    end

    # 循環している、かつstrがその文字列だけで構成されている場合にcycleを更新
    if (str.slice(0, len) == str.slice(len, len)) && (str.delete(str.slice(0, len)).length == 0)
      cycle = len
      str = str.slice(0, len)
    end

  end

  # puts n.to_s + " " + str
  return cycle
end

answer = [0, 0] # answer, length
cycle = 1

2.step(@until-1) do |n|
  bd_n = BigDecimal(n.to_s)
  
  # サイクルの長さを更新
  cycle = recurring_cycle(n.to_i, answer[1])

  # 最長の場合は更新
  if cycle.to_i > answer[1].to_i
    puts n.to_s + " " + cycle.to_s
    answer = [n, cycle]
  end
  
end

puts answer[0]
