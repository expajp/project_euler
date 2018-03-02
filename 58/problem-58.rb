# coding: utf-8
# Problem 58

=begin
1から始めて, 以下のように反時計回りに数字を並べていくと, 辺の長さが7の渦巻きが形成される.

37	36	35	34	33	32	31
38	17	16	15	14	13	30
39	18	5	4	3	12	29
40	19	6	1	2	11	28
41	20	7	8	9	10	27
42	21	22	23	24	25	26
43	44	45	46	47	48	49
面白いことに, 奇平方数が右下の対角線上に出現する. もっと面白いことには, 対角線上の13個の数字のうち, 8個が素数である. ここで割合は8/13 ≈ 62%である.

渦巻きに新しい層を付け加えよう. すると辺の長さが9の渦巻きが出来る. 以下, この操作を繰り返していく. 対角線上の素数の割合が10%未満に落ちる最初の辺の長さを求めよ.
=end

def prime?(n)
  return false if n <= 1 || (n != 2 && n % 2 == 0)
  return true if n == 2
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end
  return true
end

n = 3
arr_len = 1
prime_len = 0
arr = []
loop do
  [*1..4].each do |i|
    j = (n-2)**2+i*(n-1)
    if prime?(j)
      arr.push(j)
      prime_len += 1
    end
  end
  arr_len += 4
  p "n = #{n}, ratio = #{prime_len/arr_len.to_f}"
  break if prime_len/arr_len.to_f < 0.1
  
  n += 2
end
  
p n
