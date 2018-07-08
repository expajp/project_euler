# coding: utf-8
# Problem 91

=begin
点P(x1, y1)と点Q(x2, y2)はともに整数係数の点であり, 原点O(0,0)と合わせてΔOPQをなす.

各係数が0と2の間にあるとき, すなわち0 ≤ x1, y1, x2, y2 ≤ 2のとき, 直角三角形は14個できる:

では, 0 ≤ x1, y1, x2, y2 ≤ 50のとき, 直角三角形は何個作れるか?
=end

p_sets = [*0..2].repeated_combination(2).to_a
           .reject{ |p| p == [0, 0]}
           .combination(2).to_a
           .reject{ |a| (a[0][0] == 0 && a[1][0] == 0) ||
                    (a[0][0] != 0 && a[1][0] != 0 && (a[0][1]/a[0][0]).to_f == (a[1][1]/a[1][0]).to_f) }

count = 0
p_sets.each do |set|
  # 長さを図ってピタゴラスの定理の逆
  lsq = []
  lsq << set[0][0]**2 + set[0][1]**2
  lsq << set[1][0]**2 + set[1][1]**2
  lsq << (set[0][0]-set[1][0])**2 + (set[0][1]-set[1][1])**2
  lsq.sort!
  count += 1 if lsq[0]+lsq[1] == lsq[2]
end
p count
