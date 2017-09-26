# Problem 22

def get_score(name, index)
  name_score = 0
  name.each_char{ |c| name_score = name_score + @alphabet_score[c].to_i}
  return name_score.to_i * index.to_i
end

@alphabet_score = Hash.new
[*'A'..'Z'].each_with_index{ |c, i| @alphabet_score[c] = i.to_i + 1 }


names = []
File.open("names.txt") do |file|
  names = file.read.delete("\"").split(",").sort
end

score = 0
names.each_with_index { |name, index| score = score + get_score(name, index.to_i+1) }

puts score.to_s
