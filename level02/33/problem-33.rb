# coding: utf-8
# Problem 33

=begin
2桁の数どうしのすべての組合せを調べる
両方10の倍数である場合は調べない
共通する数がない場合も調べない
共通する数がある場合、ユークリッドの互除法で最大公約数を調べる
最大公約数が1である場合は調べない
最大公約数が1でない場合、その数で分母分子をそれぞれ割る
取り除いた数についても最大公約数を調べて、その数で分母分子でそれぞれ割る
前2つを比較して、一致していたらOK
=end

# ユークリッドの互除法で最大公約数を求める
def euclidean(a, b)
  if a > b && b != 0
    euclidean(a%b, b)
  elsif a < b && a != 0
    euclidean(a, b%a)
  else
    return (a > b ? a : b)
  end
end

answer_num = 1
answer_den = 1
10.step(99) do |a|
  (a+1).step(99) do |b|
    next if a%10 == 0 && b%10 == 0

    flg = false
    common = ''
    a.to_s.each_char do |c|
      if b.to_s.include?(c)
        common = c
        flg = true
      end
    end
    next if !flg

    max_div = euclidean(a, b)
    next if max_div == 1

    removed_a = a.to_s.delete(common).to_i
    removed_b = b.to_s.delete(common).to_i
    max_div_removed = euclidean(removed_a, removed_b)
    next if removed_b == 0

    if a/max_div == removed_a/max_div_removed && b/max_div == removed_b/max_div_removed
      puts "#{a} / #{b},  #{a/max_div} / #{b/max_div}"
      answer_num = answer_num * a
      answer_den = answer_den * b
    end
    
  end
end

puts (answer_den/euclidean(answer_num, answer_den)).to_s
