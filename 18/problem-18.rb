# Problem 18

heap = Array.new()
File.open("data.txt") do |file|
  file.each_line do |line|
    buf_array = Array.new()
    row = line.split(" ")
    row.each_with_index do |value, index|
      if index != 0 && index != row.length-1
        buf_array.push(value)
        buf_array.push(value)
      else
        buf_array.push(value)
      end
    end
    heap.push(buf_array)
  end
end

heap = heap.flatten()
puts heap.to_s
