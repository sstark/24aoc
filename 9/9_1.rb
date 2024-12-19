#!/usr/bin/env ruby

disk = []
adr = 0
id = 0

loop do
  c = ARGF.readchar
  break if c == "\n"
  val = c.to_i
  if adr.even?
    val.times do
      disk << id
    end
    id += 1
  else
    val.times do
      disk << nil
    end
  end
  adr += 1
end

# p disk

class Array
  def popnnil
    x = self.pop
    while x == nil
      x = self.pop
    end
    return x
  end
end

disk.each.with_index do |x, i|
  if x == nil
    disk[i] = disk.popnnil
  end
end

# p disk

p disk.compact.map.with_index { |x, i| x * i }.sum
