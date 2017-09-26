# Problem 42

def triangle_score(word)
  score = 0
  word.each_char{ |c| score = score + @alphabet_num[c] }
  return score 
end

def triangle?(word)
  score = triangle_score(word)

  doubled_sc = score*2
  n_0 = Math.sqrt(doubled_sc).floor
  n_1 = Math.sqrt(doubled_sc).ceil
  
  # score == n(n+1)/2
  # -> 2*score == n(n+1)
  # -> n^2 < n(n+1) < (n+1)^2
  # -> n < sqrt(n(n+1) < n+1
  if doubled_sc % n_0 == 0 && doubled_sc % n_1 == 0 && n_1 == n_0 + 1
    # puts word + " " + score.to_s
    return true
  else
    return false
  end
end
  
@words = []
File.open("p042_words.txt") do |file|
  @words = file.read.delete("\"").split(",").sort
end

@alphabet_num = Hash.new
[*'A'..'Z'].each_with_index{|c, i| @alphabet_num[c] = i.to_i + 1}

answer = 0
@words.each{|w| answer = answer + 1 if triangle?(w)}

puts answer.to_s
