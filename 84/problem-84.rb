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
１回目のサイコロを振る
ゾロ目かどうか関係なく、マスの指示に従う
ゾロ目ならば、もう一度サイコロを振る

上位を調べれば良いので、探索の深さを決める

@diceroll_tableを順に調べる
出たマスに進み、そこの指示に従う
止まったら、そこに数を記す
単位は(16*36)^3分の1
ゾロ目ならば、もう一度@diceroll_tableを調べる
これを3回繰り返す
=end

dice = 4

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
  r_map.find{ |r| point < r }
end  

def execute_instruction(point, unit)
  @diceroll_table.each_with_index do |second, i|
    next if second.nil?
    second.each_with_index do |num, j|
      next if num.nil?
      if i == j
        # pointだけ更新
        # もう一度サイコロを振る  
      else
        # @pを更新
        # 次の出目を調べる
      end
      
=begin
      point = num
      command = @board[point][0..1]
      
      case command
      when "G2" then
        @p[@board.index("JAIL")] += unit*unit
      when "CC" then
        @p[point] += unit*14
        @p[@board.index("GO")] += unit
        @p[@board.index("JAIL")] += unit
      when "CH" then
        @p[point] += unit*6
        @p[@board.index("GO")] += unit
        @p[@board.index("JAIL")] += unit
        @p[@board.index("C1")] += unit
        @p[@board.index("E3")] += unit
        @p[@board.index("H2")] += unit
        @p[@board.index("R1")] += unit
        @p[next_r(point)] += unit*2
        if @board[point-3][0..1] != "G2" || @board[point-3][0..1] != "CC" || @board[point-3][0..1] != "CH"
          @p[point-3] += unit
        else
          execute_instruction(point-3, unit/16)
        end
      else
        @p[point] += unit*unit
      end
=end
    end
  end
end
 
@p = @board.dup.map{ |elm| elm = 0 } # 各マスに止まる確率
execute_instruction(point, 16**6)
p @p
