# Problem 15

lattice = Array.new(21).map{Array.new(21)}

lattice[0].fill(1)
lattice.each do |arr|
  arr[0] = 1
end

puts lattice.to_s

