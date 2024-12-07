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
    @startpos = start
    @dir = start_dir
    # Keep track of visited positions and all directions we had while visiting.
    # If we encounter both, position and direction a second time we know we
    # have a loop.
    @track = {}
    @loop = false
  end

  def vec_add(a, b)
    ya, xa = a
    yb, xb = b
    return [ya+yb, xa+xb]
  end

  def outside?(pos)
    y, x = pos
    return y < 0 || x < 0 || y > @dim - 1 || x > @dim - 1
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

  def update_track(pos, dir)
    @track[pos] = @track.fetch(pos, []) << dir
  end

  def walk()
    self.update_track(@pos, @dir)
    next_position = self.vec_add(@pos, @dir)
    y, x = next_position
    if self.outside? next_position
      return nil
    elsif @obstacles[y][x]
      self.rotate
    else
      @pos = next_position
    end
    if self.loop?
      @loop = true
      return nil
    end 
    return @pos
  end

  def track()
    return @track
  end

  def loop?()
    return @track.fetch(@pos, []).include? @dir
  end

  def trapped?()
    return @loop
  end

  def draw()
    (0..@dim-1).each do |y|
      (0..@dim-1).each do |x|
        if @track[[y,x]]
          print "X"
        elsif @obstacles[y][x]
          print "#"
        else
          print "."
        end
      end
      print "\n"
    end
  end

  def startpos()
    return @startpos
  end

end

guard = Guard.new(width, obstacles, start, start_dir)
loop do
  break if guard.walk == nil
end
track = guard.track
startpos = guard.startpos

traps = 0
(0..width-1).each do |y|
  puts y
  (0..width-1).each do |x|
    next if [y,x] == startpos
    next if !track[[y,x]]
    # deep copy. Lame but works to reset obstacles
    o = Marshal.load(Marshal.dump(obstacles))
    o[y][x] = true
    guard = Guard.new(width, o, start, start_dir)
    loop do
      break if guard.walk == nil
    end
    if guard.trapped?
      traps += 1
      # guard.draw
    end
  end
end

puts "traps: #{traps}"
