# coding: utf-8
# Problem 71

=begin
nとdを正の整数として, 分数 n/d を考えよう. n<d かつ HCF(n,d)=1 のとき, 真既約分数と呼ぶ.

d ≤ 8について既約分数を大きさ順に並べると, 以下を得る:

1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8
3/7のすぐ左の分数は2/5である.

d ≤ 1,000,000について真既約分数を大きさ順に並べたとき, 3/7のすぐ左の分数の分子を求めよ.
=end

# subject.to n < m
def hcf(n, m)
  if m < n
    buf = m
    m = n
    n = buf
  end
  return n if m%n == 0
  hcf(m%n, n)
end

def get_rpfs(max_d)
  arr = []
  2.upto(max_d) do |d|
    1.upto(d-1) do |n|
      arr.push([n,d]) if hcf(n,d) == 1
    end
  end
  arr
end

p get_rpfs(10000).length
