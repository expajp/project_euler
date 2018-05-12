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
  return if digits.length > 2
  ret = []
  [*0..material.length].combination(digits.length).to_a.each do |combi|
    arr = material.dup
    combi.each_with_index do |c, i|
      arr.insert(c, digits[i])
    end
    ret.push(arr)
  end
  ret
end

answers = [keylog[0]]

keylog.each_with_index do |log, i|
  next if i == 0
  
  suitable_answers = answers.select do |ans|
    idx = log.map{ |l| ans.index(l) }
    !idx.any?(&:nil?) && idx[0] < idx[1]
  end
  if suitable_answers.any?
    answers = suitable_answers
    next
  end

  new_answers = []  
  answers.each do |ans|
    idx = log.map{ |l| ans.index(l) }
    if idx.all?{ |i| i.nil? }
      add_digits(ans, log).each{ |new_ans| new_answers << new_ans }
    elsif idx[0]
      head = ans[0..idx[0]]
      new_tails = add_digits(ans[idx[0]+1..ans.length-1], [log[1]])
      new_tails.each{ |new_tail| new_answers << head+new_tail }
    elsif idx[1]
      tail = ans[idx[1]..ans.length-1]
      new_heads = add_digits(ans[0..idx[1]-1], [log[0]])
      new_heads.each{ |new_head| new_answers << new_head+tail }
    end
  end
  answers = new_answers.select{ |ans| ans.length == new_answers.map(&:length).min }
end
p answers.map{ |ans| ans.inject(:+) }.uniq
