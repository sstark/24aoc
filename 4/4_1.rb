#!/usr/bin/env ruby

arr = ARGF.readlines.map(&:chomp)
DIRS = {
  U: [-1,0], D: [1,0], L: [0,-1], R: [0,1],
  UL: [-1,-1], UR: [-1,1], DL: [1,-1], DR: [1,1]
}

class Array
  def aa_s(word, start, dir)
    y, x = start
    dy, dx = dir
    testword = []
    word.size.times do |i|
      if y < 0 || x < 0 || y >= self.size || x >= self[0].size
        return false
      end
      testword << self[y][x]
      y += dy
      x += dx
    end
    return testword.join == word
  end
end

n = 0
arr.size.times do |y|
  arr[0].size.times do |x|
    DIRS.values.each do |v|
      n += 1 if arr.aa_s("XMAS", [y,x], v)
    end
  end
end

puts n
