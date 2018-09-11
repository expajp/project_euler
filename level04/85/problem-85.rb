# coding: utf-8
# Problem 85

=begin
注意深く数えると, 横が3, 縦が2の長方形の格子には, 18個の長方形が含まれている.

ぴったり2,000,000個の長方形を含むような長方形の格子は存在しない. 一番近い解を持つような格子の面積を求めよ.
=end

# 長方形の横、縦の長さ
answers = []

width = 3
loop do
  p "width: #{width}"
  1.upto(width) do |height|
    rectangles = 0
    
    1.upto(width) do |w|
      1.upto(height) do |h|
        rectangles += (width-(w-1))*(height-(h-1))
      end
    end
    answers << { area: width*height, rectangles: rectangles } if rectangles > 1990000 && rectangles < 2000000
  end
  width += 1
  break if width > 200
end

p answers.sort{ |a, b| b[:rectangles] <=> a[:rectangles] }
