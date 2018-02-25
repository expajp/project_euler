# coding: utf-8
# Problem 57

=begin
2の平方根は無限に続く連分数で表すことができる.

√ 2 = 1 + 1/(2 + 1/(2 + 1/(2 + ... ))) = 1.414213...
最初の4回の繰り返しを展開すると以下が得られる.

1 + 1/2 = 3/2 = 1.5
1 + 1/(2 + 1/2) = 7/5 = 1.4
1 + 1/(2 + 1/(2 + 1/2)) = 17/12 = 1.41666...
1 + 1/(2 + 1/(2 + 1/(2 + 1/2))) = 41/29 = 1.41379...

次の3つの項は99/70, 239/169, 577/408である. 第8項は1393/985である. これは分子の桁数が分母の桁数を超える最初の例である.

最初の1000項を考えたとき, 分子の桁数が分母の桁数を超える項はいくつあるか?
=end

class Fraction
  attr_accessor :element, :denominator

  def initialize(elm, den)
    @element = elm
    @denominator = den
  end

  # 通分
  def reduce_to_common_den
  end

  # 分数表示
  def to_s
    "#{@element}/#{@denominator}"
  end

  # 加算
  def add
  end

  private

  # 約分
  def reduce
  end

  # 分母と分子の最大公約数を求める
  def get_max_common_divisor(m, n)
    
  end

  # 約数を求める
  def get_divisors(n)
  end  
end

# 工数を指定して再帰的に求める
frac = Fraction.new(1,2)
p frac.to_s
