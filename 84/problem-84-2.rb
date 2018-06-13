# coding: utf-8
# Problem 84

=begin
各プレイヤーはGOのマスから開始し, 2個の6面サイコロを用いて時計回りに進む. 他のルールが無いとすれば, 各マスに止まる確率は全て等しく, 2.5%である. しかし, G2J (Go To Jail), CC (Community Chest, 共同基金), CH (Chance, チャンス) のマスによってこの確率は変えられてしまう.
---
とりあえず、2.5%になる設定を考える
=end

# 盤面
@board = [
  "GO", "A1", "CC1", "A2", "T1", "R1", "B1", "CH1", "B2", "B3",
  "JAIL", "C1", "U1", "C2", "C3", "R2", "D1", "CC2", "D2", "D3",
  "FP", "E1", "CH2", "E2", "E3", "R3", "F1", "F2", "U2", "F3",
  "G2J", "G1", "G2", "CC3", "G3", "R4", "CH3", "H1", "T2", "H2"
] # 各マスの名称はunique

@cc = [
  "GO", "JAIL", nil, nil, nil, nil, nil, nil,
  nil, nil, nil, nil, nil, nil, nil, nil
]

@ch = [
  "GO", "JAIL", "C1", "E3", "H2", "R1", "next_r", "next_r",
  "next_u", "back_by_3", nil, nil, nil, nil, nil, nil
]

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

def draw_on_ch(np)
  ret = @ch.shift
  @ch.push(ret)
  case ret
  when "next_r"
    next_r(np)
  when "next_u"
    next_u(np)
  when "back_by_3"
    nnp = (np-3+40)%40
    ch3?(np) ? draw_on_cc(nnp) : nnp
  when nil
    np
  else
    @board.index(ret)
  end
end

def draw_on_cc(np)
  ret = @cc.shift
  @cc.push(ret)
  ret.nil? ? np : @board.index(ret)
end

def next_point(point, a, b)
  np = (point+a+b)%40
  if jumping_square?(np)
    case @board[np][0..1]
    when 'G2'
      return @board.index('JAIL')
    when 'CC'
      return draw_on_cc(np)
    when 'CH'
      return draw_on_ch(np)
    end
  else
    return np
  end
end

def sequence(point, times, max)
  return @board.index('JAIL') if times == 4
  a = diceroll(max)
  b = diceroll(max)
  point = next_point(point, a, b)
  
  if a == b
    sequence(point, times+1, max)
  else
    point
  end
end

@p = []
40.times{ |i| @p[i] = 0 }

max = 4
point = @board.index("GO")
@ch.shuffle!
@cc.shuffle!

10000000.times do |i|
  point = sequence(point, 1, max)
  @p[point] += 1
end

sum = @p.sum
@p.map!.with_index{ |p, i| { p: (p/sum.to_f*100).round(3), i: i } }.sort_by!{ |h| -h[:p] } # .map!{ |h| h[:i] }
p @p
