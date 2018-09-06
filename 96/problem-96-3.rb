# coding: utf-8
# Problem 96

=begin
愚直に、「左上から順に埋めていき、矛盾が発生したらバックトラックする」というアルゴリズムを考える
矛盾が発生すると、そのマスのpossible_digitsが0になるからわかる
=end

class Sudoku
  def initialize(table)
    @table = table
  end

  def view(table = @table)
    p '---'
    table.each_with_index do |row, i|
      p row[0..2].join('') + ' ' + row[3..5].join('') + ' ' + row[6..8].join('')
      p '' if i%3 == 2 && i != 8
    end
    p '---'
  end

  def solve
    preprocessing(@table)
    if cleared?
      view(@table)
      return
    end
    solver(@table)
    view(@table)
  end
  
  def cleared?
    !(@table.flatten.find{ |n| n == 0 })
  end
  
  def answer
    @table[0][0..2].map(&:to_s).join('').to_i
  end

  private

  def solver(table)
    sp = searching_point(table)
    return nil if sp.empty?
    p_digits = possible_digits(table, sp[0], sp[1])
    p_digits.each do |n|
      trying_table = copy_table(table)
      trying_table[sp[0]][sp[1]] = n
      solver(trying_table)
    end    
  end

  def searching_point(table)
    point = []
    table.each_with_index do |row, i|
      row.each_with_index{ |n, j| point = [i, j] if n == 0 }
    end
    return point
  end

  def preprocessing(table)
    before_table = []
    loop do
      table = pp_sequence(table)
      break if table == before_table
      before_table = copy_table(table)
    end
    table
  end

  def possible_digits(table, i, j)
    block = table[(i/3)*3, 3].map{ |a| a[(j/3)*3, 3] }.flatten
    [*1..9] - (table[i]+table.transpose[j]+block).reject{ |n| n == 0 }.uniq
  end

  def pp_sequence(table)
    copied_table = copy_table(table)
    copied_table.each_with_index do |row, i|
      row.each_with_index do |n, j|
        next if n != 0
        p_digits = possible_digits(table, i, j)
        if p_digits.length == 1
          table[i][j] = p_digits.first
          return table
        end
      end
    end
    table
  end

  def copy_table(table)
    ret = []
    table.each_with_index{ |row, i| ret[i] = row.dup }
    ret
  end

end

sudokus = []
File.open("sudoku.txt") do |f|
  table = []
  f.each_line.with_index do |line, i|
    if line.match(/Grid [0-9]+/)
      table = []
      next
    end
    table[i%10-1] = line.gsub(/\n/, '').split('').map(&:to_i)
    sudokus << Sudoku.new(table) if i%10 == 9
  end
end

sudokus[0..1].each(&:solve)
# p [sudokus[8], sudokus[40]].map(&:answer).sum
