# coding: utf-8
# Problem 79

=begin
オンラインバンクで通常使われるsecurity methodは, 
パスコードからランダムに選んだ3文字をユーザーに要求するものである.

たとえば, パスコードが531278のとき, 2番目, 3番目, 5番目の文字を要求されるかもしれない. 
このとき, 期待される答えは: 317 である.

テキストファイルkeylog.txtには, ログインに成功した50回の試行が記録されている.

3つの文字が常に順番通りに要求されるとするとき, 
ファイルを分析して, 可能なパスコードのなかでもっとも短いものを見つけよ.
=end

keylog = []
File.open("keylog.txt") do |f|
  f.each_line do |line|
    line.gsub!(/\n/, "")
    arr = []
    line.each_char{ |c| arr << c }
    arr.each_cons(2){ |con| keylog << con }
  end
end

def add_digits(material, digits)
  ret = []
  [*0..material.length].combination(2).to_a.each do |c|
    arr = material.dup
    arr.insert(c[0], digits[0])
    arr.insert(c[1]+1, digits[1])
    ret.push(arr)
  end
  ret
end

p add_digits([0, 1, 2], [3, 4])

# answer = []
=begin
keylog.each_with_index do |log, i|
  idx = log.map{ |n| answer.index(n) }
  if idx.map(&:nil?).inject(:&)
    answer.push(log).flatten!
  elsif idx.include?(nil)
    new_val = log[idx.index(nil)]
    if 1-idx.index(nil) == 0
      answer.push(new_val)
    else
      answer.unshift(new_val)
    end
  else
    if idx[0] < idx[1]
      # do nothing
    else
      if answer.slice(idx[0], answer.length-idx[0]).index(log[1]).nil?
        answer.push(log[1])
      end
    end
  end
  p "log=#{log}, i=#{i}, answer=#{answer.inject(:+)}"
  # break if i == 25
end
p answer.inject(:+)
=end

