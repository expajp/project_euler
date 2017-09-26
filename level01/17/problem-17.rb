# Problem 17

# until 20
numbers = [
  "",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
  "ten",
  "eleven",
  "twelve",
  "thirteen",
  "fourteen",
  "fifteen",
  "sixteen",
  "seventeen",
  "eighteen",
  "nineteen",
  "twenty"
]

# thirty to ninety step by 10
numbers[30] = "thirty"
numbers[40] = "forty"
numbers[50] = "fifty"
numbers[60] = "sixty"
numbers[70] = "seventy"
numbers[80] = "eighty"
numbers[90] = "ninety"

result = 0
999.times do |n|
  hundreds = 100*(n+1).div(100)
  tens = 10*(n+1).modulo(100).div(10)
  ones = (n+1).modulo(10)

  # 100の位
  if hundreds > 0
    # puts numbers[hundreds.div(100)]
    result += numbers[hundreds.div(100)].length
    result += "hundred".length

    # ちょうど100,200,...,900以外の場合はandがいる
    if (tens+ones) != 0
      result += "and".length
    end
  end

  # 10の位と1の位
  if (tens+ones).between?(1,20)
    result += numbers[tens+ones].length
  elsif (tens+ones) <= 99
    result += numbers[tens].length
    result += numbers[ones].length
  end
end

# 1000
result += "one thousand".delete(" ").length

puts result
