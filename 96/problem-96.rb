# coding: utf-8
# Problem 9§

=begin
"数独"(日本語で数字を配置するという意味)とは人気があるパズルの名前である. 起源は不明だが, その評判はラテン語で"Squares"と呼ばれる同様な, そしてはるかに難しいパズルを考案した レオンハルト・オイラーの貢献によるものに違いない. しかしながら, "数独"パズルの目的は それぞれの行, 列が3×3の枠を含む9×9の格子の空白（もしくは0）をそれぞれ1から9の数字で置き換えることである. 下に, 一般的なパズルの開始状態とその解答の例がある.

うまく作られている"数独"パズルは, 選択肢を消去するために"仮定とテスト"方式を用いる必要があるかもしれないが, ただ一つの解を持ち, 論理によって解くことができる(これについては様々な意見がある).

探索の複雑さがパズルの難易度を決定する; 上に挙げた例は, 単純で直接的な推論によって解く事ができるため, 簡単であると考えられる.

6kバイトのテキストファイルfilesudoku.txt(右クリックで,"名前をつけてリンク先を保存") にはただ一つの解を持つ, 様々な難易度の50の"数独"パズルが含まれている(上の例題はこのファイルにおける最初のパズルである).

50すべてのパズルを解き, それぞれの解答の左上隅にある3桁の数の合計を求めよ; 例えば483は上の解答例の左上隅の3桁の数である.
---

ある0について、縦横ブロックを調べて入る数字の可能性が1つしかないものを埋める
Grid 01はこれで解ける

次に、それでも埋まらない場合について、候補の少ないものから調べていく
ここの調べ方が重要、可能性の議論


=end

def sequence(table)
  table.each_with_index do |row, i|
    row.each_with_index do |n, j|
      next if n != 0
      block = table[(i/3)*3, 3].map{ |a| a[(j/3)*3, 3] }.flatten
      cross_and_block = row+table.transpose[j]+block
      collection = cross_and_block.reject{ |n| n == 0 }.uniq
      if collection.length == 8
        table[i][j] = ([*1..9]-collection).first
        return table
      end
    end
  end
  table
end

def solve(table)
  view(table)
  
  # 埋められる場所を埋める
  # 不整合が起きたらハネて枝刈りする仕組みが必要
  before_table = copy_table(table)
  loop do
    table = sequence(table)
    return table if cleared?(table)
    break if compare_table(table, before_table)
    before_table = copy_table(table)
  end

  map = evaluation_map(table)
  max = map.map{ |row| row.max }.max
  points = points_from_val(map, max)

  # p points
  points.each do |point|
    searching_table = copy_table(table)
    nominated = nominated(searching_table, point)
    return nil if nominated.length == 0
    nominated.each do |n|
      searching_table[point[:i]][point[:j]] = n
      # view(searching_table)
      next if solve(searching_table).nil?
    end
  end
end

def evaluation_map(table)
  table = table.map.with_index do |row, i|
    row.map.with_index do |n, j|
      if n != 0
        0
      else
        block = table[(i/3)*3, 3].map{ |a| a[(j/3)*3, 3] }.flatten
        (row+table.transpose[j]+block).reject{ |n| n == 0 }.uniq.length
      end      
    end
  end
  table
end

def points_from_val(table, val)
  ret = []
  table.each_with_index do |row, i|
    row.each_with_index do |n, j|
      ret << {i: i, j: j} if n == val
    end
  end
  ret
end

def nominated(table, point)
  i = point[:i]
  j = point[:j]
  row = table[i]
  block = table[(i/3)*3, 3].map{ |a| a[(j/3)*3, 3] }.flatten
  [*1..9] - (row+table.transpose[j]+block).reject{ |n| n == 0 }.uniq
end

def view(table)
  p '---'
  table.each_with_index do |row, i|
    p row[0..2].join('') + ' ' + row[3..5].join('') + ' ' + row[6..8].join('')
    p '' if i%3 == 2 && i != 8
  end
  p '---'
end

def compare_table(a, b)
  a.map.with_index{ |row, i| row == b[i] }.all?
end

def copy_table(table)
  ret = []
  table.each_with_index{ |row, i| ret[i] = row.dup }
  ret
end

def cleared?(sudoku)
  !(sudoku.flatten.find{ |n| n == 0 })
end

answer = 0
File.open("sudoku.txt") do |f|
  table = []
  f.each_line.with_index do |line, i|
    if line.match(/Grid [0-9]+/)
      p line.gsub(/\n/, '')
      table = []
    else
      table[i%10-1] = line.gsub(/\n/, '').split('').map(&:to_i)
    end
    
    if i%10 == 9
      table = solve(table)
      answer += table[0][0..2].map(&:to_s).join('').to_i
      view(table) if i%10 == 9
    end
    break if i == 19
  end
end
p answer
