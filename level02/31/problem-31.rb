# Problem 31

@coins = [1, 2, 5, 10, 20, 50, 100, 200]
@coins = @coins.reverse

@answer = 0

def coin_pick(max_index, limit)
  if max_index == @coins.length-1
    @answer = @answer + 1
    # puts "#{@coins[max_index]}*#{limit} "
    return
  end

  max_num = limit.div(@coins[max_index])
  max_num.step(0, -1) do |num|
    # print "#{@coins[max_index]}*#{num} "
    coin_pick(max_index.to_i+1, limit.to_i-@coins[max_index]*num)
  end
end

limit = 200
coin_pick(0, limit)

puts @answer.to_s
