# coding: utf-8
# Problem 84

=begin
各プレイヤーはGOのマスから開始し, 2個の6面サイコロを用いて時計回りに進む. 他のルールが無いとすれば, 各マスに止まる確率は全て等しく, 2.5%である. しかし, G2J (Go To Jail), CC (Community Chest, 共同基金), CH (Chance, チャンス) のマスによってこの確率は変えられてしまう.
---
とりあえず、2.5%になる設定を考える
=end

dice = 6

# サイコロの出目
# すべての確率は等しいので、これを舐めれば全条件の検証になる
# 問題に回答するとき、ここの6を4にする
@diceroll_table = []
1.upto(dice) do |i|
  @diceroll_table[i] = []
  1.upto(dice) do |j|
    @diceroll_table[i][j] = i+j
  end
end

# 盤面
@board = [
  "GO", "A1", "CC1", "A2", "T1", "R1", "B1", "CH1", "B2", "B3",
  "JAIL", "C1", "U1", "C2", "C3", "R2", "D1", "CC2", "D2", "D3",
  "FP", "E1", "CH2", "E2", "E3", "R3", "F1", "F2", "U2", "F3",
  "G2J", "G1", "G2", "CC3", "G3", "R4", "CH3", "H1", "T2", "H2"
] # 各マスの名称はunique

def diceroll(max)
  rand(max)+1
end

def next_r(point)
  r_map = @board.select{ |sq| sq[0] == "R" }.map{ |sq| @board.index(sq) }.sort
  r_map.find{ |r| point < r } || 5
end  

def next_u(point)
  u_map = @board.select{ |sq| sq[0] == "U" }.map{ |sq| @board.index(sq) }.sort
  u_map.find{ |u| point < u } || 12
end  

def jumping_square?(point)
  ['CC', 'CH'].include?(@board[point][0..1]) || @board[point] == 'G2J'
end

def ch3?(point)
  @board[point] == 'CH3'
end

@p = []
40.times{ |i| @p[i] = 0 }

max = 6
point = @board.index("GO")
10000000.times do |i|
  loop do
    first = diceroll(max)
    second = diceroll(max)
    point = (point+first+second)%40
    break if first != second
  end
  @p[point] += 1
end

sum = @p.sum
@p.map!{ |i| i/sum.to_f*100 }
p @p
