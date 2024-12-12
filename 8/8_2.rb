#!/usr/bin/env ruby

class AntennaMap

  def initialize
    @map = ARGF.readlines.map(&:chomp)
    @width = @map[0].size
    @height = @map.size
    scannodes
  end

  def drawmap
    puts @map
  end

  def drawnodes
    p @nodes
  end

  def scannodes
    @nodes = {}
    @map.each_with_index do |line,y|
      line.split("").each.with_index do |c,x|
        next if c == "."
        n = @nodes.fetch(c, [])
        @nodes[c] = n << [y,x]
      end
    end
  end

  def nodes
    return @nodes
  end

  def addnode(c, coord)
    y, x = coord
    @map[y][x] = c
  end

  def preflect(a, s)
    ay, ax = a
    sy, sx = s
    return [sy+2*(ay-sy), sx+2*(ax-sx)]
  end

  def preflect_all(a, s)
    ay, ax = a
    sy, sx = s
    out = [a, s]
    y = sy+2*(ay-sy)
    x = sx+2*(ax-sx)
    unless y < 0 || x < 0 || y > @height-1 || x > @width-1
      out << [y, x]
    end
    loop do
      y = y+(ay-sy)
      x = x+(ax-sx)
      break if y < 0 || x < 0 || y > @height-1 || x > @width-1
      out << [y, x]
    end
    return out
  end

  def detect_antinodes
    @antinodes = {}
    @nodes.each do |type, coords|
      coords.combination(2).each do |pair|
        pair.permutation.each do |p|
          preflect_all(*p).each do |refl|
            n = @antinodes.fetch(type, [])
            @antinodes[type] = n << refl
          end
        end
      end
    end
  end

  def antinodes
    return @antinodes
  end

end

map = AntennaMap.new
map.detect_antinodes
puts map.antinodes.values.flatten(1).uniq.size
