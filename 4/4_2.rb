#!/usr/bin/env ruby

arr = ARGF.readlines.map(&:chomp)

class Array
  
  @@xs = [ %w[M M S S], %w[S S M M], %w[S M S M], %w[M S M S] ]

  def get_corners(start)
    y, x = start
    c1 = self[y-1][x-1]
    c2 = self[y-1][x+1]
    c3 = self[y+1][x-1]
    c4 = self[y+1][x+1]
    return [c1, c2, c3, c4]
  end

  def aa_x(start)
    y, x = start
    return false if self[y][x] != "A"
    return false if x < 1 || x > self[0].size-2
    return false if y < 1 || y > self.size-2
    return @@xs.include? self.get_corners(start)
  end

end

n = 0
arr.size.times do |y|
  arr[0].size.times do |x|
    n += 1 if arr.aa_x([y,x])
  end
end

puts n
