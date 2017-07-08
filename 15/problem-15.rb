# Problem 15

lattice = Array.new(21).map{Array.new(21)}

# initialize
lattice[0].fill(1)
lattice.each do |arr|
  arr[0] = 1
end

# calculate
lattice.each_with_index do |row, i|
  if i > 0
    row.each_with_index do |value, j|
      if j > 0
        lattice[i][j] = lattice[i-1][j].to_i + lattice[i][j-1].to_i
      end
    end
  end
end

# output result
puts lattice[20][20]
