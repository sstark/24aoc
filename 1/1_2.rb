#!/usr/bin/env ruby

left, right = ARGF.map(&:split).transpose
class Array
  def elemdistance
     return (self[0].to_i - self[1].to_i).abs
  end
end
puts left.sort.zip(right.sort).map(&:elemdistance).sum
