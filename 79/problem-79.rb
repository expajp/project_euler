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

answer = []

keylog.each do |log|
  answer.push(log) if answer.length == 0
  # 両方存在しない場合はdigitsに2つとも放り込む
  # 片方だけ存在するは数字より前or後ろだけmaterialにしてdigitsに1つ放り込む
  # 両方順番通りに存在する場合はそのまま
  # 両方存在するけど順番通りでない場合は片方をそのままにするパターンを2通り考える
end
p answer
