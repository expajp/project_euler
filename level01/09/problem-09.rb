# coding: utf-8
# Problem 09

[*1..998].each do |a|
  [*(a+1)..998].each do |b|
    val = a*a+b*b
    next if val > 998*998
    c = 1000-a-b
    if val == c*c
      p a*b*c
      return
    end
  end
end
