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

def compare_with_frac(base_frac, frac)
  n = frac[0]*base_frac[1]
  compared_n = base_frac[0]*frac[1]

  return 0 if n == compared_n
  n-compared_n > 0 ? 1 : -1
end

max = 1000000
answer_div = max
answer = [1,1]
1.upto(max/7) do |d_div|
  (d_div*7).upto(d_div*7+6) do |d|
    (d_div*2+1).upto(d_div*3-1) do |n|
      if 3/7.0-n/d.to_f < answer_div
        answer_div = 3/7.0-n/d.to_f
        answer = [n,d]
        p "answer_div = #{answer_div}, answer = #{answer}"
      end
      break if compare_with_frac([n,d], [3,7]) > 0
    end
  end 
end
p "answer_div = #{answer_div}, answer = #{answer}"
