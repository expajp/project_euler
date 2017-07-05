# Problem 13

# 各行ごとの処理
def read_line(line, answer)
  # answer[0]には上10桁、answer[1]には上11桁目～20桁目を足す
  answer[0] += line.slice(0, 10).to_i
  answer[1] += line.slice(10, 10).to_i

  # answer[1]から繰り上がりがあれば反映
  if answer[1] >= 10^10
    answer[0] += 1
    answer[1] = answer[1] % 10^10
  end

  # 配列を返す
  return answer
end

# 初期化
answer = [0, 0]

# ファイルを開き、各行ごとに処理を行う
File.open "data.txt", 'r' do |f|
    f.each_line{ |line| answer = read_line(line, answer) }
end

# 結果を表示
puts answer[0].to_s.slice(0, 10)
