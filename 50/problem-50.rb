# coding: utf-8
# Problem 50

=begin
n以下の素数のうち、連続する最長の素数列の和で表せるものを求める

2から順番に素数の入った配列を作っていく
→素数列の入った配列の末尾に次の素数を追加していく

ある素数列に対して、連続する素数列の和を求めてリストアップする
素数列に次に大きい素数を一つ追加する
新しく追加される「連続する素数列の和」は、
「元の素数列の最大値を含む和」に「新しく追加した素数」を足したモノ
になる
よって、これを帰納的に繰り返してnを超えた時点でストップする

列の長さ、和、含まれる最大の素数をセットで持っておく必要がある
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

def hash_fac(sum, chain, max)
  ret = Hash.new
  ret["sum"] = sum
  ret["chain"] = chain
  ret["max"] = max
  return ret
end

def prime_chain(n)
  hash_arr = Array.new
  hash_arr.push(hash_fac(2,1,2))
  hash_arr.push(hash_fac(3,1,3))
  hash_arr.push(hash_fac(5,2,3))
  return hash_arr if n < 5

  p = [2, 3]
  i = 5
  loop do
    if prime?(i)
      p_max = p.max
      p.push(i)
      puts "p_max: #{p_max}, i: #{i}"
      hash_arr.each do |h|
        next if h["max"] != p_max
        hash_arr.push(hash_fac(h["sum"]+i, h["chain"]+1, i))
      end
    end
    i = i + 2
    break if i > n
  end
  return hash_arr
end

puts prime_chain(7).to_s
