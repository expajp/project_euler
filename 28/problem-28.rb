# Problem 28

size = 1001
start = (size/2).floor
row = start
col = start

matrix = Array.new(size).map{Array.new(size, 0)}

matrix[row][col] = 1
col = col.to_i + 1

3.step(size, 2) do |n|
  ((n-2)**2+1).step(n**2, 1) do |i|
    matrix[row][col] = i
    # puts matrix.to_s
    # puts (i-(n-2)**2).to_s
      
    if i-(n-2)**2 <= (n-2)
      row = row + 1
    elsif i-(n-2)**2 <= (n-2)+(n-1)
      col = col - 1
    elsif i-(n-2)**2 <= (n-2)+2*(n-1)
      row = row - 1
    else
      col = col + 1
    end
  end  
end

# puts matrix.to_s

answer = 0
size.times do |i|
  answer = answer.to_i + (matrix[i][i].to_i + matrix[i][size-1-i].to_i)
end
answer = answer - 1

puts answer.to_s
