#!/usr/bin/env ruby

UP = [-1,0]
R = [0,1]
DOWN = [1,0]
L = [0,-1]

input = ARGF.readlines
width = input.size
obstacles = Array.new(width) { |x| [] }
start = []
start_dir = []
input.map(&:chomp).each_with_index do |line, y|
  line.split("").each_with_index do |c, x|
    case c
    when "#"
      obstacles[y][x] = true
    when "^"
      start = [y, x]
      start_dir = UP
    when ">"
      start = [y, x]
      start_dir = R
    when "v"
      start = [y, x]
      start_dir = DOWN
    when "<"
      start = [y, x]
      start_dir = L
    end
  end
end

class Guard

  def initialize(dim, obstacles, start, start_dir)
    @dim = dim
    @obstacles = obstacles
    @pos = start
    @dir = start_dir
    @track = [start]
  end

  def vec_add(a, b)
    ya, xa = a
    yb, xb = b
    return [ya+yb, xa+xb]
  end

  def outside?(pos)
    y, x = pos
    return y < 0 || x < 0 || y > @dim - 2 || x > @dim - 2
  end

  def rotate()
    case @dir
    when UP
      @dir = R
    when R
      @dir = DOWN
    when DOWN
      @dir = L
    when L
      @dir = UP
    end
  end

  def walk()
    next_position = self.vec_add(@pos, @dir)
    y, x = next_position
    if @obstacles[y][x]
      self.rotate
    elsif self.outside? next_position
      @track << @pos
      return nil
    else
      @track << @pos
      @pos = next_position
    end
    return @pos
  end

  def track()
    return @track
  end

end

guard = Guard.new(width, obstacles, start, start_dir)
loop do
  break if guard.walk == nil
end
puts guard.track.uniq.size+1
