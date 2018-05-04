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

p keylog
answer = []
keylog.each do |log|
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
    # ここが一番厄介
    # 両方存在する場合、前後関係の修正で対処できない場合は追加
    # 前後関係の修正で対処できないという判定はどこでするんだろうか。。。
  end
end
p answer.inject(:+)
