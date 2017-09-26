# Problem 18

tree = Array.new()
File.open("data.txt") do |file|
  file.each_line do |line|
    tree.push(line.split(" "))
  end
end

tree = tree.reverse

answer = 0

# 底から2番目の深さのデータから、順に上っていく
# 1つ深いデータとの間の部分木は深さ1の2分木なので、最大値は簡単にわかる
# 求めた最大値を順に2分木の根にあたる位置に代入していくと木の高さが1つずつ減っていく
tree.each_with_index do |depth, i|
  if i > 0
    depth.each_with_index do |value, j|
      depth[j] = depth[j].to_i + (tree[i-1][j] > tree[i-1][j+1] ? tree[i-1][j].to_i : tree[i-1][j+1].to_i)
    end
    answer = depth.max
  end
end

puts answer
