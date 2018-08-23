# coding: utf-8
# Problem 96

=begin
とりあえずリファクタリングがいるんじゃなかろうか

ある0について、縦横ブロックを調べて入る数字の可能性が1つしかないものを埋める
Grid 01はこれで解ける

次に、それでも埋まらない場合について、候補の少ないものから調べていく
ここの調べ方が重要

ある場所が埋まっていなくても候補は絞られていて、それによって確定する箇所が存在する
という状況をいかに表すか

セルに対して複数の値を持てるようにコードを組み直し、それに対してsequenceをかける
とすると、埋まらない箇所が増えるだけ

問題文を読み直すと「仮定とテスト」方式を用いる必要がある、とあるので、これがおそらくヒント
仮定を取り、テストをして、矛盾が発生すればその枝は切れる

唯一の解を持つことから、最善計算量が少なくなる深さ優先探索で正解
幅優先だと総当たりに限りなく近づいてしまう

これでもやっぱり解けない場合がある
おそらく原因は
 * 矛盾があって絶対に解けない場合
 * 仮定が足りない場合
の区別ができていないこと
しかし、矛盾がある場合をどうやって検出する？
=end

class Sudoku
  def initialize(table)
    @table = table
  end

  def view(table)
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
    sps =  searching_points(table)
    p sps
    searching_points(table).each do |i, j|
      possible_digits(table, i, j).each do |digit|
        copied_table = copy_table(table)
        copied_table[i][j] = digit
        p 'before'
        view(copied_table)
        
        updated_table = preprocessing(copy_table(copied_table))
        
        p 'after'
        view(updated_table)

        if !(updated_table.flatten.find{ |n| n == 0 })
          @table = updated_table
          return nil
        elsif copied_table == updated_table || searching_points(updated_table).nil?
          next
        end
        return nil if solver(updated_table).nil?
      end
    end
  end

  def searching_points(table)
    e_map = table.map.with_index do |row, i|
      row.map.with_index do |n, j|
        n == 0 ? 9-possible_digits(table, i, j).length : 0
      end
    end
    map_max = e_map.map{ |row| row.max }.max
    return nil if map_max == 0 || map_max == 9
    ret = []
    e_map.each_with_index{ |row, i| row.each_with_index{ |n, j| ret << [i, j, n] } }
    ret.sort{ |a, b| b[2] <=> a[2] }.map{ |a| a[0..1] }
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

answer = 0
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

=begin
(sudokus[0..7]+[sudokus[0]]+sudokus[9..39]+[sudokus[0]]+sudokus[41..49]).each_with_index do |sudoku, i|
  p "Grid #{i}"
  sudoku.solve
end
=end

sudokus[8].solve
# sudokus[40].solve
