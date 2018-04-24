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

@patterns = [nil, 0]

# snp = sum notation patterns
def snp(n)
  return @patterns[n] unless @patterns[n].nil?
  @patterns[n] = [*1..(n/2).ceil].map{ |i| 1+snp(n-i) }.inject(:+)
  [*(n/2).ceil+1..n-1].each do |i|
    if n-i < i
      p snp(n-i)
      @patterns[n] += snp(n-i)
      @patterns[n] += 1 if n-i == 1
    else
      div = n/i
      mod = n%i
      p "div=#{div}, mod=#{mod}"
    end
  end
  p "@patterns[#{n}] = #{@patterns[n]}"
  @patterns[n]
end

p snp(5)
