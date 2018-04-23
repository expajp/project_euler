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

@patterns = [nil, 1] 

# snp = sum notation patterns
def snp(n)
  return @patterns[n] unless @patterns[n].nil?
  @patterns[n] = [*1..n-1].map{ |i| snp(i) }.inject(:+)
  p "@patterns[#{n}] = #{@patterns[n]}"
  @patterns[n]
end

p snp(5)
