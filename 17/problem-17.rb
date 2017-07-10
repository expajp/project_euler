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
  tens = 10*(n+1).div(10)
  ones = (n+1).modulo(10)

  if hundreds > 0
    result += numbers[hundreds.div(100)].length
    result += "hundred".length
    result += "and".length
  end

  if (tens+ones).between?(0,20)
    result += numbers[tens+ones].length
  elsif (tens+ones) <= 99
    result += numbers[tens].length
    result += numbers[ones].length
  end

end

result += "one thousand".delete(" ").length

puts result
