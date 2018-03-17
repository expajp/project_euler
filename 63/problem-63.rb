# coding: utf-8
# Problem 63

=begin
5桁の数 16807 = 75は自然数を5乗した数である. 同様に9桁の数 134217728 = 89も自然数を9乗した数である.

自然数を n 乗して得られる n 桁の正整数は何個あるか?
=end

n = 1
answer = 0
loop do
  break if (9**n).to_s.length < n
  p "n = #{n}, length of 9^n = #{(9**n).to_s.length}" # 2^n = #{2**n}, 
  i = 1
  loop do
    check = (i**n).to_s
    break if check.length > n
    if check.length == n
      p "#{i}^#{n} = #{check}"
      answer += 1
    end
    i += 1
  end
  n += 1
end
p "answer = #{answer}"
