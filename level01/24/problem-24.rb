# Problem 24

def factorial(n)
  return (n <= 1 ? 1 : n*factorial(n-1))
end

def permutations(arr)
  if arr.length <= 1
    return arr
  end
  ret = []
  arr.each do |n|
    excluded = arr.dup
    excluded.delete(n)
    permutations(excluded).each{ |elm| ret.push(n.to_s + elm.to_s) }
  end
  return ret
end

material = []
10.times{ |n| material.push(n) }
# ('A'..'J').to_a.each {|c| material.push(c)} # 20桁ならばアルファベット10個も含める

answer = ""
buffer = 1000000

# 階乗を利用して桁を一つずつ特定
loop do
  f = factorial(material.length.to_i-1)
  n = (buffer/f).floor

  # 階乗での絞込ができなくなる（＝絞り込もうとすると規定の番号を超過する）場合はbreak
  break if buffer.to_i - f*n <= 0

  buffer = buffer.to_i - f*n
  answer = answer + material[n].to_s
  material.delete(material[n])
end

# 残りは総当りで求めて、該当する番号のやつをピックアップ
answer = answer.to_s + (permutations(material).sort)[buffer.to_i-1].to_s
puts answer.to_s

__END__

hoge = []
10.times{ |n| hoge.push(n) }
puts (permutations(hoge).sort)[999999]

この方法でもいけるっぽい
10桁なら常識的な計算時間に収まる
ただし、上の方法なら20桁の1億番目とかも一瞬で求まる
