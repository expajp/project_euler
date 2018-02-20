# coding: utf-8
# Problem 54

=begin
=end

@change_table = { 'T': 10, 'J': 11, 'Q': 12, 'K': 13, 'A': 14 }
def change_num(num)
  return @change_table[num.to_sym] if @change_table.keys.include?(num.to_sym)  
  return num.to_i if num.to_i >= 2 && num.to_i <= 9
  return nil
end

# 数字だけでできた配列が同じ数字を2つ以上含む場合、
# 最初にでてきたものがいくつあるか数えて返す
def get_how_many_same_nums(arr)
  arr.sort!
  ret = 0
  arr.each_cons(2).with_index do |a, i|
    p "#{a}, #{i}"
    if a[0] == a[1]
      ret += (ret > 0 ? 1 : 2)
    elsif ret > 0
      p arr-arr[0..i]
      return { count: ret, left: arr-arr[0..i] }
    end
  end
  { count: ret, left: [] }
end

def get_nums_from_hand(hand)
  hand.map{|card| card[:number]}
end

p get_how_many_same_nums([1,1,3,4,5])
# hand = [{:number=>3, :suit=>"D"}, {:number=>8, :suit=>"H"}, {:number=>11, :suit=>"D"}, {:number=>13, :suit=>"D"}, {:number=>14, :suit=>"S"}]

# p get_nums_from_hand(hand)

def loyal_numbers?(hand)
end

def straight?(hand)
end

def flash?(hand)
end

def four_cards?(hand)
end

def three_cards?(hand)
end

def full_house?(hand)
end

def two_pairs?(hand)
end

def one_pair?(hand)
  
end

=begin
all_cards = []
File.open("poker.txt") do |f|
  f.each_line do |line|
    line.gsub!(/\n/, "")
    arr = line.split(' ')
    cards = []
    arr.each{ |card| cards.push({'number': change_num(card.slice(0,1)), 'suit': card.slice(1,1)}) }
    all_cards.push([cards[0..4].sort_by{ |c| c[:number] }, cards[5..9].sort_by{ |c| c[:number] }])
    p all_cards.last
  end
end

=end
