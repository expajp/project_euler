# coding: utf-8
# Problem 32

=begin
i桁*j桁=[i+j-1, i+j]桁

つまり、i+j+(i+j-1)=2i+2j-1, i+j+(i+j)=2i+2jのいずれかに
9を含まないといけない
後者は必ず偶数なので、前者が9
よって、i+j=5であることが必須

i<jの縛りを加えると探索数はかなり少なくなるはず
=end

answer = []
numbers = ('1'..'9').to_a

1.step(99) do |i|
  next if i % 10 == 0
  
  i_digit = i.to_s.length
  j_digit = 5 - i_digit
  
  (10**(j_digit-1)).step(10**(j_digit+1)-1) do |j|
    next if j % 10 == 0
    
    buf = []
    i.to_s.each_char{|c| buf.push(c)}
    j.to_s.each_char{|c| buf.push(c)}
    (i*j).to_s.each_char{|c| buf.push(c)}
    buf = buf.sort
    
    if buf == numbers
      puts "#{i} #{j} #{i*j}"
      answer.push(i*j)
    end
    
  end  
end

answer = answer.uniq
puts answer.inject(:+).to_s
