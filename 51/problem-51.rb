# coding: utf-8
# Problem 51

=begin
*3の第1桁を置き換えることで, 13, 23, 43, 53, 73, 83という6つの素数が得られる.

56**3の第3桁と第4桁を同じ数で置き換えることを考えよう. 
この5桁の数は7つの素数をもつ最初の例である: 56003, 56113, 56333, 56443, 56663, 56773, 56993. 
よって, この族の最初の数である56003は, このような性質を持つ最小の素数である.

桁を同じ数で置き換えることで8つの素数が得られる最小の素数を求めよ. (注:連続した桁でなくても良い)
=end

def prime?(n)
  return false if n <= 1
  return true if n == 2
  return false if n != 2 && n % 2 == 0
 
  limit = Math.sqrt(n).ceil
  3.step(limit, 2) do |i|
    return false if n % i == 0
  end

  return true
end

=begin
先頭の桁を含むかどうかで場合分けの必要がある
先頭の桁を含む場合、0が使えない
また、8個ということは末尾の桁は含まない

n桁の数について、m(m < n-1)個の数字を置き換える
0, 1, 2のうち1つでも素数があれば3, 4, ...と検証していく
先頭桁を含む場合、素数でない数が2つあれば探索終了
含まない場合、素数でない数が3つあれば探索終了
探索中、最も小さい数字は覚えておかないといけない

探索はnを徐々に大きくしていく
mを順に与えるが、先頭桁を含む場合と含まない場合に分けて検証する
m=1のときは「先頭桁を含まない」

n=2について考える
*1で素数なのは、11,31,41,61,71

以下同様に、
*3 ... 13, 23, 43, 53, 73, 83
*7 ... 17, 37, 47, 67, 97
*9 ... 19, 29, 59, 79, 89

これをリストアップすることを最初の目標にする
=end
n = 2
m = 1

# n桁の整数の「文字列」の配列を返す
def n_digits_str(n)
  return nil if n < 1
  return [*0..9].map(&:to_s) if n == 1
  [*(10**(n-1))..(10**n)-1].map(&:to_s)
end

def starred_arrays(arr, digits)
  ret = []
  (digits+1).times do |i|
    dupped_arr = arr.dup
    ret.push(dupped_arr.each{ |str| str.insert(i, '*') })
  end
  ret
end

starred_arr = starred_arrays(n_digits_str(n-m), n-m)

p starred_arr