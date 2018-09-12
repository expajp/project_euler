# coding: utf-8
# Problem 11

table = []
File.open('input.txt') do |f|
  f.each_line do |l|
    table << l.gsub(/\n/, '').split(' ').map(&:to_i)
  end
end

t_table = table.transpose
max = 0
table.each.with_index do |row, i|
  row.each.with_index do |n, j|
    vals = [max]
    # 横
    vals << row[j..(j+3)].inject(:*) if j+3 < 20
    
    # 縦
    vals << t_table[j][i..(i+3)].inject(:*) if i+3 < 20
    
    # 右下
    vals << [table[i][j], table[i+1][j+1], table[i+2][j+2], table[i+3][j+3]].inject(:*) if i+3 < 20 && j+3 < 20
    
    # 左下
    vals << [table[i][j], table[i-1][j+1], table[i-2][j+2], table[i-3][j+3]].inject(:*) if i-3 >= 0 && j+3 < 20

    max = vals.max
  end
end
p max
