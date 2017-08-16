# Problem 31

@coins = [1, 2, 5, 10, 20, 50, 100, 200]
@coins = @coins.reverse

@answer = 0

def coin_pick(max_index, limit)
  if limit == 0 || max_index >= @coins.length
    @answer = @answer + 1
    puts ""
    return
  end
  
  max_num = limit.div(@coins[max_index])
  max_num.step(0, -1) do |num|
    print @coins[max_index].to_s + "*" + num.to_s + " "
    coin_pick(max_index.to_i+1, limit.to_i-@coins[max_index]*num)
  end
end

limit = 10
coin_pick(4, limit)

puts @answer.to_s

# puts @coins.to_s
