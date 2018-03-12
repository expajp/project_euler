# coding: utf-8
# Problem 60

=begin
三角数, 四角数, 五角数, 六角数, 七角数, 八角数は多角数であり, それぞれ以下の式で生成される.

三角数	P3,n=n(n+1)/2	1, 3, 6, 10, 15, ...
四角数	P4,n=n2	1, 4, 9, 16, 25, ...
五角数	P5,n=n(3n-1)/2	1, 5, 12, 22, 35, ...
六角数	P6,n=n(2n-1)	1, 6, 15, 28, 45, ...
七角数	P7,n=n(5n-3)/2	1, 7, 18, 34, 55, ...
八角数	P8,n=n(3n-2)	1, 8, 21, 40, 65, ...
3つの4桁の数の順番付きの集合 (8128, 2882, 8281) は以下の面白い性質を持つ.

この集合は巡回的である. 最後の数も含めて, 各数の後半2桁は次の数の前半2桁と一致する
それぞれ多角数である: 三角数 (P3,127=8128), 四角数 (P4,91=8281), 五角数 (P5,44=2882) がそれぞれ別の数字で集合に含まれている
4桁の数の組で上の2つの性質をもつはこの組だけである.
三角数, 四角数, 五角数, 六角数, 七角数, 八角数が全て表れる6つの巡回する4桁の数からなる唯一の順序集合の和を求めよ.


順序付きの配列だが、最初の要素はなんでもよい
よって、最初の要素を三角数に固定し、三角数を順に調べる
深さ優先探索で、先頭2文字が一致するやつを順に調べて行って駄目なら手戻り
調べたpolygonalを保持する配列を作り、手戻りしたら再度配列に値を追加

=end

@polygonal = []
def set_polygonal  
  3.upto(8) do |n|
    @polygonal[n] = []
    i = 1
    loop do
      case n
      when 3 then
        j = i*(i+1)/2
      when 4 then
        j = i*i
      when 5 then
        j = i*(3*i-1)/2
      when 6 then
        j = i*(2*i-1)
      when 7 then
        j = i*(5*i-3)/2
      when 8 then
        j = i*(3*i-2)
      else
        return
      end
      if j < 1000
        i += 1
        next
      end
      break if j > 9999
      @polygonal[n].push(j)
      i += 1
    end
  end
end

def search_cyclical(edge, chain)
  @polygonal[edge.shift].each do |n|
    if chain.empty?
      search_cyclical(edge.dup, [n])      
    else
      if chain.last.to_s.slice(-2,2) == n.to_s.slice(0,2)
        if edge.empty? && n.to_s.slice(-2,2) == chain.first.to_s.slice(0,2)
          chain.push(n)
          p chain
          p chain.inject(:+)
          exit
        elsif edge.any?
          search_cyclical(edge.dup, chain.dup.push(n))
        end
      end
    end
  end
end

set_polygonal()

edges = []
[*4..8].permutation(5).each{ |a| edges.push(a.unshift(3)) }
edges.each{ |edge| search_cyclical(edge, []) }

