# coding: utf-8
# Problem 54

=begin
=end

@change_table = { 'T': 10, 'J': 11, 'Q': 12, 'K': 13, 'A': 14 }

# 手札の役と最大値を調べる

# 数字だけでできたソート済配列が同じ数字を2つ以上含む場合、
# 最初にでてきたものがいくつあるか数え、残りの配列とセットで返す
def get_how_many_same_nums(arr)
  arr.sort!
  ret = 0
  arr.each_cons(2).with_index do |a, i|
    if a[0] == a[1]
      ret += (ret > 0 ? 1 : 2)
    elsif ret > 0
      return { count: ret, left: arr-arr[0..i] }
    end
  end
  { count: ret, left: [] }
end

# 手札から数字だけ抽出した配列を返す
def get_nums_from_hand(hand)
  ret = []
  hand.each{ |card| ret.push(card[:number]) }
  ret
end

def flash?(hand)
  suit = hand[0][:suit]
  hand[1..-1].each{ |card| return false if suit != card[:suit]  }
  true
end

def straight?(nums)
  nums.each_cons(2) { |a, b| return false if b-a != 1 }
  true
end

def loyal_straight?(nums)
  nums[0] == 10 && straight?(nums)
end

# 渡された手札の役と、役を構成するカードの最高値を求める
def get_score_of_hand(hand)
  nums = get_nums_from_hand(hand)
  return { rank: 9, high: nums[4] } if loyal_straight?(nums) && flash?(hand) # loyal straight flash
  return { rank: 8, high: nums[4] } if straight?(nums) && flash?(hand) # straight flash

  hash_a = get_how_many_same_nums(get_nums_from_hand(hand))
  hash_b = get_how_many_same_nums(hash_a[:left])

  return { rank: 7, high: (nums-hash_a[:left]).max } if hash_a[:count] == 4 # four card
  return { rank: 6, high: nums[4] } if hash_a[:count]*hash_b[:count] == 6 # full house
  return { rank: 5, high: nums[4] } if flash?(hand) # flash
  return { rank: 4, high: nums[4] } if straight?(nums) # straight

  return { rank: 3, high: (nums-hash_a[:left]).max } if hash_a[:count] == 3 # three card
  return { rank: 2, high: (nums-hash_b[:left]).max } if hash_a[:count] == 2 && hash_b[:count] == 2 # two pairs
  return { rank: 1, high: (nums-hash_a[:left]).max } if hash_a[:count] == 2 # one pair
  { rank: 0, high: nums[4] } # pig
end

# アルファベットで表された数字を数字に変換する
def change_num(num)
  return @change_table[num.to_sym] if @change_table.keys.include?(num.to_sym)  
  return num.to_i if num.to_i >= 2 && num.to_i <= 9
  return nil
end

win_count = 0
File.open("poker.txt") do |f|
  f.each_line do |line|
    line.gsub!(/\n/, "")
    arr = line.split(' ')
    
    cards = []
    arr.each{ |card| cards.push({'number': change_num(card.slice(0,1)), 'suit': card.slice(1,1)}) }

    player_1 = get_score_of_hand(cards[0..4].sort_by{ |c| c[:number] })
    player_2 = get_score_of_hand(cards[5..9].sort_by{ |c| c[:number] })
    
    if player_1[:rank] > player_2[:rank]
      win_count += 1
    elsif (player_1[:rank] == player_2[:rank] && player_1[:high] > player_2[:high])
      win_count += 1
    end
  end
end

p win_count
