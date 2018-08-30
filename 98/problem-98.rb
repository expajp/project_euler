# coding: utf-8
# Problem 98

=begin
CARE という単語の各文字をそれぞれ 1, 2, 9, 6 に置き換えることによって, 平方数 1296 = 36^2 ができる. 注目すべきことに, 同じ数字の置換をつかうことにより, アナグラムの RACE も平方数 9216 = 96^2 をつくる. CARE (と RACE) を平方アナグラム単語対と呼ぼう. 先頭のゼロは許されず, 異なる文字が同じ数字をもつこともないとする.

約 2,000 個の一般的な英単語を含む 16K のテキストファイルfile:words.txt (右クリックして "名前をつけてリンク先を保存") を用いて, 平方アナグラム単語対をすべて求めよ (回文となる単語はそれ自身のアナグラムとはみなさない).

そのような対のメンバーから作られる最大の平方数は何か?

注: 作られるアナグラムは, すべて与えられたテキストファイルに含まれている.
=end

arr = []
File.open("words.txt") do |f|
  arr = f.gets.gsub(/\"/, '').split(',')
end

def anagram(word, arr)
  characters = word.split('')
  arr.each do |w|
    word_characters = w.split('')
    # p characters.map{ |c| word_characters.include?(c) }
    # p word_characters.map{ |c| characters.include?(c) }
    return w if characters.map{ |c| word_characters.include?(c) }.inject(:&) && word_characters.map{ |c| characters.include?(c) }.inject(:&) && word != w && word.length == w.length
  end
  nil
end

p arr[1]
p anagram(arr[1], arr)
