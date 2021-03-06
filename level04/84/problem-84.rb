# coding: utf-8
# Problem 84

=begin
各プレイヤーはGOのマスから開始し, 2個の6面サイコロを用いて時計回りに進む. 
他のルールが無いとすれば, 各マスに止まる確率は全て等しく, 2.5%である. 
しかし, G2J (Go To Jail), CC (Community Chest, 共同基金), CH (Chance, チャンス) のマスによってこの確率は変えられてしまう.

G2Jに止まる, または, CCやCHのマスに止まると引くカードのうちそれぞれ1枚によって, プレイヤーはJAILのマスに飛ばされる.
またプレイヤーが連続して3回ゾロ目を出すと, 3投目の結果のマスに進むのではなく, 直接JAILのマスに飛ばされる. 
(訳注: モノポリーではゾロ目が出るともう1回サイコロをふる. 6,6→2,1の場合は合計15マス進む. 4,4→2,2→1,2の場合は合計15マス進む. 3,3→4,4→2,2の場合は6マス目, 14マス目に止まったのちJAILに飛ばされる.)

ゲーム開始前にCCカードとCHカードはシャッフルされる. 
プレイヤーがCCまたはCHマスに止まった場合, プレイヤーはCCカードまたはCHカードの山の一番上からカードを1枚引く. カードの指示に従ったのち, そのカードは山の一番下に戻される. 
それぞれのカードは16枚あるが, 今回は問題を進み方に限定するので, 移動の指示があるカードのみを考える. 移動の指示が無いカードに関しては何もせずカードをそのまま山の下に戻す. プレイヤーはそのままCC/CHマスに残るものとする.

Community Chest (16枚中2枚が移動カード)
GOへ進め
JAILへ進め

Chance (16枚中10枚が移動カード)
GOへ進め
JAILへ進め
C1へ進め
E3へ進め
H2へ進め
R1へ進め
次のRへ進め (Rはrailway company, 鉄道会社の意)
次のRへ進め
次のUへ進め (Uはutility company, 公共事業会社の意)
3マス戻れ

今回考えるのは, どのマスに止まりやすいかである. 即ち, サイコロを投げた後に止まる確率である. より正確には, サイコロを1回振ってカードやマスによる移動を終えた後に各マスに止まる確率を求めたい. 従って, G2Jに止まる確率は0であり, CHマスに止まる確率はその次に少ない(16枚中10枚が移動カードなので). またJAILマスにたまたま止まることとJAILマスに送られることを区別しない. またJAILマスから抜けるルール (自分のターンにゾロ目を2回出す) を無視する. つまり必ず保釈金を払ってJAILマスから進むものとする.

GOマスを00とし番号を00-39と順番に振る. これにより各マスを2桁の数で表すことが出来る.

統計的には, 3つのマスに止まりやすいことを示せる. JAIL (6.24%) = 10番目, E3 (3.18%) = 24番目, GO (3.09%) = 00番目である. 従ってもっとも止まりやすいマスを6桁で表せて102400となる.

2つの6面サイコロではなくて, 2つの4面サイコロを用いた場合の, もっとも止まりやすいマスを6桁で表せ.

（翻訳ヒント、サイコロを振りぞろ目だろうがでなかろうが止まったマス目の指示に従う。カードマスならカードを引く。これを繰り返す。繰り返す途中で三連続でぞろ目が出たら強制的に刑務所行き）
--
1回目のサイコロを振る

ゾロ目でないなら、
  pointを進める
  進めた先がG2J, CC, CHかどうか調べる
  いずれでもなければ@pのpointの位置に加算
  G2J, CC, CH1, CH2ならば確率に従ってジャンプ先の@pに加算
  CH3ならば、3マス戻れ以外は確率に従ってジャンプ先の@pに加算
  CH3で3マス戻れならば、CC3に行くので、確率にしたがってジャンプ先の@pに加算
ゾロ目なら、
  pointを進める
  進めた先がG2J, CC, CHかどうか調べる
  いずれでもなければ始点を止まったマスにずらし、unitはそのままで再度2回目のサイコロを振る
  G2J, CC, CH1, CH2ならば始点を止まったマスにずらし、unitを確率に応じて減らして2回目のサイコロを振る
  CH3ならば、3マス戻れ以外は始点を止まったマスにずらし、unitを確率に応じて減らして2回目のサイコロを振る
  CH3で3マス戻れならば、CC3に行くので、unitを確率に応じて減らして2回目のサイコロを振る

2回目のサイコロを振る試行は同じ
3回目のサイコロを振る試行はゾロ目でないならば同じ
ゾロ目ならば、JAILの@pにunitを減らさずに加算

再帰的に@pを加算していく形になる
統計学を用いなくても、調べきることは可能

サイコロを振る試行において、変数として必要な情報は
始点、unit、ゾロ目が連続で出た数

unitの初期値は、ある出目に対して
  CH3で3マス戻れを引く確率が1/16, CCで移動カードを引く確率が1/16
なので、256とする
1回目の試行でCH3に止まることはないが、これの3乗を初期値にすればわかりやすい

unitは1/36を表す値
ゾロ目になった場合、次のunitはさらに1/36なのでこれを考慮して呼び出す
ゾロ目かつカードコマに止まった場合、次のunitは(1/36)*(1/16)
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

# unitは1/36を表す
def add_p(point, unit)
  # p "#{point}, #{unit}"
  if ch3?(point) # CH3
    @p[point] += (unit/16)*6
    @p[@board.index("GO")] += (unit/16)
    @p[@board.index("JAIL")] += (unit/16)
    @p[@board.index("C1")] += (unit/16)
    @p[@board.index("E3")] += (unit/16)
    @p[@board.index("H2")] += (unit/16)
    @p[@board.index("R1")] += (unit/16)
    @p[next_r(point)] += (unit/16)*2

    @p[point] += (unit/(16*16))*14
    @p[@board.index("GO")] += (unit/(16*16))
    @p[@board.index("JAIL")] += (unit/(16*16))
  elsif jumping_square?(point) # G2J, CH, CCのいずれか
    case @board[point][0..1]
    when "G2" then
      @p[@board.index("JAIL")] += unit
    when "CC" then
      @p[point] += (unit/16)*14
      @p[@board.index("GO")] += (unit/16)
      @p[@board.index("JAIL")] += (unit/16)
    when "CH" then
      @p[point] += (unit/16)*6
      @p[@board.index("GO")] += (unit/16)
      @p[@board.index("JAIL")] += (unit/16)
      @p[@board.index("C1")] += (unit/16)
      @p[@board.index("E3")] += (unit/16)
      @p[@board.index("H2")] += (unit/16)
      @p[@board.index("R1")] += (unit/16)
      @p[next_r(point)] += (unit/16)*2
      @p[next_u(point)] += (unit/16)
      @p[(point-3+40)%40] += (unit/16)
    end
  else
    @p[point] += unit
  end
end

def execute_instruction(point, unit, times)
  p "#{' '*(times-1)}execute_instruction(#{@board[point]}(#{point}), #{unit}, #{times})"
  original_point = point
  @diceroll_table.each_with_index do |row, i|
    next if row.nil?
    row.each_with_index do |num, j|
      next if num.nil?
      point = (original_point+num)%40
      p "#{' '*(times-1)}point: #{@board[point]}(#{point}), num: #{num}"
      if i == j # ゾロ目
        new_unit = { normal: unit/36, card: unit/(36*16), ch3: unit/(36*16*16) }
        if times >= 3
          @p[@board.index('JAIL')] += unit
          next
        elsif ch3?(point)
          execute_instruction(point, new_unit[:card]*6, times+1)
          execute_instruction(@board.index("GO"), new_unit[:card], times+1)
          execute_instruction(@board.index("JAIL"), new_unit[:card], times+1)
          execute_instruction(@board.index("C1"), new_unit[:card], times+1)
          execute_instruction(@board.index("E3"), new_unit[:card], times+1)
          execute_instruction(@board.index("H2"), new_unit[:card], times+1)
          execute_instruction(@board.index("R1"), new_unit[:card], times+1)
          execute_instruction(next_r(point), new_unit[:card]*2, times+1)
          execute_instruction(next_u(point), new_unit[:card], times+1)

          execute_instruction(point, new_unit[:ch3]*14, times+1)
          execute_instruction(@board.index("GO"), new_unit[:ch3], times+1)
          execute_instruction(@board.index("JAIL"), new_unit[:ch3], times+1)
        elsif jumping_square?(point)
          case @board[point][0..1]
          when "G2" then
            execute_instruction(@board.index("JAIL"), new_unit[:normal], times+1)
          when "CC" then
            execute_instruction(point, new_unit[:card]*14, times+1)
            execute_instruction(@board.index("GO"), new_unit[:card], times+1)
            execute_instruction(@board.index("JAIL"), new_unit[:card], times+1)
          when "CH" then
            execute_instruction(point, new_unit[:card]*6, times+1)
            execute_instruction(@board.index("GO"), new_unit[:card], times+1)
            execute_instruction(@board.index("JAIL"), new_unit[:card], times+1)
            execute_instruction(@board.index("C1"), new_unit[:card], times+1)
            execute_instruction(@board.index("E3"), new_unit[:card], times+1)
            execute_instruction(@board.index("H2"), new_unit[:card], times+1)
            execute_instruction(@board.index("R1"), new_unit[:card], times+1)
            execute_instruction(next_r(point), new_unit[:card]*2, times+1)
            execute_instruction(next_u(point), new_unit[:card], times+1)
            execute_instruction((point-3+40)%40, new_unit[:card], times+1)
          end
        else
          execute_instruction(point, new_unit[:normal], times+1)
        end
      else
        # p "add_p(#{@board[point]}, #{unit})"
        add_p(point, unit)
      end
    end
  end
end

p @diceroll_table
@p = @board.dup.map{ |elm| elm = 0 } # 各マスに止まる確率
execute_instruction(0, (16**4)*(36**3), 1)
@p.map!.with_index{ |p, i| { p: p, i: i } }.sort_by!{ |h| -h[:p] } # .map!{ |h| h[:i] }
p @p
