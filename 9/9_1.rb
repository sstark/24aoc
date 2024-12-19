#!/usr/bin/env ruby

class Disk < Array
  def initialize
    adr = 0
    id = 0
    loop do
      c = ARGF.readchar
      break if c == "\n"
      val = c.to_i
      if adr.even?
        val.times do
          self << id
        end
        id += 1
      else
        val.times do
          self << nil
        end
      end
      adr += 1
    end
  end

  def popnnil
    x = self.pop
    while x == nil
      x = self.pop
    end
    return x
  end

  def defrag_blocks
    self.each.with_index do |x, i|
      if x == nil
        self[i] = self.popnnil
      end
    end
  end

  def checksum
    self
      .compact
      .map
      .with_index { |x, i| x * i }
      .sum
  end
end

disk = Disk.new
disk.defrag_blocks
p disk.checksum
