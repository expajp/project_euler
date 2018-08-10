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

=end

class Sudoku
  def initialize(table)
    @table = table
  end

  def view
    p '---'
    @table.each_with_index do |row, i|
      p row[0..2].join('') + ' ' + row[3..5].join('') + ' ' + row[6..8].join('')
      p '' if i%3 == 2 && i != 8
    end
    p '---'
  end

  def cleared?
    !(@table.flatten.find{ |n| n == 0 })
  end
  
  def answer
    @table[0][0..2].map(&:to_s).join('').to_i
  end
end

answer = 0
sudokus = []
File.open("sudoku.txt") do |f|
  table = []
  f.each_line.with_index do |line, i|
    if line.match(/Grid [0-9]+/)
      p line.gsub(/\n/, '')
      table = []
    else
      table[i%10-1] = line.gsub(/\n/, '').split('').map(&:to_i)
    end
    sudokus << Sudoku.new(table) if i%10 == 9
  end
end

