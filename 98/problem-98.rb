# coding: utf-8
# Problem 98

=begin
CARE という単語の各文字をそれぞれ 1, 2, 9, 6 に置き換えることによって, 平方数 1296 = 36^2 ができる. 注目すべきことに, 同じ数字の置換をつかうことにより, アナグラムの RACE も平方数 9216 = 96^2 をつくる. CARE (と RACE) を平方アナグラム単語対と呼ぼう. 先頭のゼロは許されず, 異なる文字が同じ数字をもつこともないとする.

約 2,000 個の一般的な英単語を含む 16K のテキストファイルfile:words.txt (右クリックして "名前をつけてリンク先を保存") を用いて, 平方アナグラム単語対をすべて求めよ (回文となる単語はそれ自身のアナグラムとはみなさない).

そのような対のメンバーから作られる最大の平方数は何か?

注: 作られるアナグラムは, すべて与えられたテキストファイルに含まれている.
=end

def square?(n)
  (Math.sqrt(n).floor)**2 == n
end

arr = []
File.open("words.txt") do |f|
  arr = f.gets.gsub(/\"/, '').split(',')
end

def anagram(word, arr)
  word_characters = word.split('')
  arr.each do |w|
    next if word.length != w.length || word == w || word.reverse == word
    
    w_characters = w.split('')
    word_in_w = word_characters.map{ |c| w_characters.include?(c) }.inject(:&)
    w_in_word = w_characters.map{ |c| word_characters.include?(c) }.inject(:&)
    
    return w if word_in_w && w_in_word
  end
  nil
end

pairs = arr.map{ |word| [word, anagram(word, arr)] }.reject{ |pair| pair[1].nil? }
squares = [nil, [1, 4, 9]]
[*2..12].each do |digits|
  squares[digits] = []
  n = Math.sqrt((squares[digits-1]).last).to_i+1
  loop do
    squares[digits] << n**2
    n += 1
    break if (n**2).to_s.length > digits
  end
end

max = 0
pairs.each do |pair|
  len = pair.first.length
  next if max > 10**(len-1)
  charas = pair.first.split('')
  squares[len].each do |sq|
    nums = sq.to_s.split('').map(&:to_i)
    table = nums.map.with_index{ |n, i| [charas[i], n] }.to_h
    ana = pair.last.split('').map{ |c| table[c] }.join.to_i
    max = [max, sq, ana].max if square?(ana)
  end
end
p max
#pairs.each do |pair|
#end
