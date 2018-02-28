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
  attr_accessor :elm, :den

  def initialize(elm, den)
    raise if den == 0
    @elm = elm
    @den = den
  end

  # 分数表示
  def to_s
    "#{@elm}/#{@den}"
  end

  # 加算
  def add(frac)
    @elm = @elm*frac.den + frac.elm*@den
    @den = @den * frac.den
    reduce()
    self
  end

  # 逆数
  def inverse
    Fraction.new(@den, @elm)
  end
  
  # 逆数（破壊的メソッド）
  def inverse!
    buf = @elm
    @elm = @den
    @den = buf
    self
  end

  private

  # 約分
  def reduce
    max_common_div = get_max_common_divisor(@elm, @den)
    @elm = @elm / max_common_div
    @den = @den / max_common_div
  end

  # 分母と分子の最大公約数を求める
  def get_max_common_divisor(m, n)
    (get_divisors(m) & get_divisors(n)).max
  end

  # 約数を求める
  def get_divisors(n)
    stop = Math.sqrt(n).ceil
    ret = [1, n]
    2.upto(stop) do |i|
      ret.push(i).push(n/i) if n%i == 0      
    end
    ret.uniq.sort
  end  
end

def get_approximation(n)
  return Fraction.new(0,1) if n < 1
  return Fraction.new(1,1).add(get_denomi(n).inverse)
end

@denomi = [0, Fraction.new(2,1)]

def get_denomi(n)
  return 0 if n < 1
  return @denomi[1] if n == 1
  return @denomi[n] if !(@denomi[n].nil?)
  ret = Fraction.new(2,1).add(get_denomi(n-1).inverse)
  @denomi[n] = ret
  ret
end

answer = 0
1.upto(1000) do |i|
  apx = get_approximation(i)
  p @denomi.map(&:to_s)
  p apx.to_s
  answer += 1 if apx.den.to_s.length != apx.elm.to_s.length
  # p "i = #{i}" if i % 10 == 0
end
p answer
