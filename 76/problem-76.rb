# coding: utf-8
# Problem 76

=begin
5は数の和として6通りに書くことができる:

4 + 1
3 + 2
3 + 1 + 1
2 + 2 + 1
2 + 1 + 1 + 1
1 + 1 + 1 + 1 + 1

2つ以上の正整数の和としての100の表し方は何通りか.
=end

@gpfnah = []

# get patterns from n and h
def gpfnah(n, h)
  return @gpfnah[n][h] unless @gpfnah[n].nil? || @gpfnah[n][h].nil?
  return 1 if h == 1
  @gpfnah[n] = [] if @gpfnah[n].nil?
  @gpfnah[n][h] = [*1..n/h].map{ |i| [*1..h-1].map{ |j| gpfnah(n-h*i, h-j) }.sum }.sum
end

# snp = sum notation patterns
def snp(n)
  [*1..n-1].map{ |i| gpfnah(n, n-i)}.sum
end

p snp(100)
