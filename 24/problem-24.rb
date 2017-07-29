# Problem 24

def factorial(n)
  return (n <= 1 ? 1 : n*factorial(n-1))
end

material = []
10.times{ |n| material.push(n) }

answer = ""
buffer = 1000000

f = factorial(material.length.to_i-1)
n = (buffer/f).floor

10.times do |i|
  buffer = buffer.to_i - f*n
  answer = answer + material[n].to_s
  material.delete(material[n])

  f = factorial(material.length.to_i-1)
  n = (buffer/f).floor

  puts (buffer.to_i-f*n).to_s + " " +  f.to_s
end

puts answer.to_s
puts material.to_s
