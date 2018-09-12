# coding: utf-8
# Problem 08

File.open('input.txt') do |f|
  numbers = f.gets.gsub(/\n/, '').split('').map(&:to_i)
  max = 0
  0.step(numbers.length-13) do |n|
    prod = numbers[n..n+12].inject(:*)
    max = prod if max < prod
  end
  p max
end
