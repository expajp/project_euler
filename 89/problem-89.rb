# coding: utf-8
# Problem 89

=begin
ローマ数字の記法は一つの数について沢山ある場合が存在する (FAQを見よ). しかし, ある数については最良の記法が必ず存在する.
例えば, 16の正しい記法を全て並べてみる.

IIIIIIIIIIIIIIII
VIIIIIIIIIII
VVIIIIII
XIIIIII
VVVI
XVI

最後の例は, 最小の文字数で表せるという意味で, 最も効率が良い.

11Kのテキストファイルfileroman.txt は1000個のローマ記法で書かれた数を含んでいる. これらは, 正しい記法に従っている. 即ち, 大きい数から順に書かれていて, 引き算ペアのルールにも従っている(このルールについてはFAQを見よ) 但し, 最小の文字数で表されているとは限らない.

最小形で書いたときに, 何文字節約できるかを求めよ.

注: ファイル中の全てのローマ数字には, 5つ以上の同じ文字が連続して含まれることはない.
---
数字に変換し、最良の表し方で数字を表し、差し引きを取って加算していく。
=end

def change_roman_to_val(roman)
  val = 0
  %w[IV IX XL XC CD CM].each_with_index do |str, i|
    unless roman.index(str).nil?
      val += (i%2 == 0 ? 4 : 9) * 10**(i/2)
      roman.gsub!(/#{str}/, '')
    end
  end
  %w[I V X L C D M].each_with_index do |c, i|
    # p "#{c} #{roman.count(c)}*#{(i%2 == 0 ? 10**(i/2) : 5*10**((i-1)/2))}"
    val += roman.count(c) * (i%2 == 0 ? 10**(i/2) : 5*10**((i-1)/2))
  end
  val
end

def change_val_to_roman(val)
  str = ""
  units = %w[1000 500 100 50 10 5 1].map(&:to_i)
  unit_notations = %w[M D C L X V I]  
  del_notations = %w[CM CD XC XL IX IV]
  
  units.each_with_index do |unit, i|
    if i%2 == 1 && val/units[i+1] == 9 
      str += del_notations[i-1]
      val = val%units[i+1]
    elsif i%2 == 0 && i != 0 && val/unit == 4
      str += del_notations[i-1]
      val = val%unit
    else
      str += unit_notations[i]*(val/unit)
      val = val%unit
    end
  end
  str
end

delegation = 0
File.open("roman.txt") do |f|
  f.each_line.with_index do |line, i|
    original = line.gsub(/\n/, '')
    val = change_roman_to_val(original.clone)
    shortest = change_val_to_roman(val)
    # p "#{original} #{val} #{shortest}"
    delegation += original.length - shortest.length
  end
end
p delegation
