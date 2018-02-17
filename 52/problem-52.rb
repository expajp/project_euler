# coding: utf-8
# Problem 52

=begin
125874を2倍すると251748となる. これは元の数125874と順番は違うが同じ数を含む.
2x, 3x, 4x, 5x, 6x が x と同じ数を含むような最小の正整数 x を求めよ.

=end

def get_sorted_arr_from_number(num)
  num.to_s.chars.map(&:to_i).sort
end

n = 9
loop do
  n += 1
  next if n.to_s.length != (n*6).to_s.length
  next if get_sorted_arr_from_number(n) != get_sorted_arr_from_number(n*2)
  next if get_sorted_arr_from_number(n) != get_sorted_arr_from_number(n*3)
  next if get_sorted_arr_from_number(n) != get_sorted_arr_from_number(n*4)
  next if get_sorted_arr_from_number(n) != get_sorted_arr_from_number(n*5)
  next if get_sorted_arr_from_number(n) != get_sorted_arr_from_number(n*6)
  break
end

p "answer = #{n}"
