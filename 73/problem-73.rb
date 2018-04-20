# coding: utf-8
# Problem 73

=begin
nとdを正の整数として, 分数 n/d を考えよう. n<d かつ HCF(n,d)=1 のとき, 真既約分数と呼ぶ.

d ≤ 8 について既約分数を大きさ順に並べると, 以下を得る:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
1/3と1/2の間には3つの分数が存在することが分かる.

では, d ≤ 12,000 について真既約分数をソートした集合では, 1/3 と 1/2 の間に何個の分数があるか?
=end

def hcf(n,m)
  # n < mを保障
  if m < n
    buf = n
    n = m
    m = buf
  end
  return n if m%n == 0
  hcf(m%n, n)
end

max = 12000
answer = 0
4.upto(max) do |d|
  (d/3.0).ceil.upto((d/2.0).floor) do |n|
    if hcf(n, d) == 1
      answer += 1
      # p "#{n}/#{d}"
    end
  end
end
p "answer = #{answer}"

