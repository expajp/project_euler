# Problem 29

answer = Array.new

2.step(100) do |a|
  2.step(100) do |b|
    answer.push(a**b)
  end
end

answer = answer.uniq.sort
puts answer.length.to_s
