# coding: utf-8
# Problem 74

=begin
145は各桁の階乗の和が145と自分自身に一致することで有名である.

1! + 4! + 5! = 1 + 24 + 120 = 145

169の性質はあまり知られていない. これは169に戻る数の中で最長の列を成す. このように他の数を経て自分自身に戻るループは3つしか存在しない.

169 → 363601 → 1454 → 169
871 → 45361 → 871
872 → 45362 → 872

どのような数からスタートしてもループに入ることが示せる.

例を見てみよう.

69 → 363600 → 1454 → 169 → 363601 (→ 1454)
78 → 45360 → 871 → 45361 (→ 871)
540 → 145 (→ 145)

69から始めた場合, 列は5つの循環しない項を持つ. また100万未満の数から始めた場合最長の循環しない項は60個であることが知られている.

100万未満の数から開始する列の中で, 60個の循環しない項を持つものはいくつあるか?
=end

def factorial(n)
  return 1 if [0,1].include?(n)
  n*factorial(n-1)
end

def sum_of_factorial_of_each_digit(n)
  n.to_s.split('').map(&:to_i).map{ |m| @fac[m] }.inject(&:+)
end

@fac = [*0..9].map{ |n| factorial(n) }
h = {}
@fac.each_with_index{ |n, i| h[i] = n }

answer = 0

10.upto(999999) do |n|
  chain = [n]
  m = n
  loop do
    h[m] = sum_of_factorial_of_each_digit(m) unless h.has_key?(m)
    m = h[m]
    break if chain.include?(m)
    chain.push(m)
  end
  if chain.length == 60
    answer += 1
    # p chain
  end
end

p "answer = #{answer}"
