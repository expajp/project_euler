# Problem 19
year = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days = 1
count = 0

100.times do |n|
  year.each_with_index do |num_of_days, month|
    days = days + num_of_days
    if n.div(4) == 0 && month == 1
      days = days + 1
    end
    if days % 7 == 0
      count = count + 1
    end

  end
end

puts count
