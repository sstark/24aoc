#!/usr/bin/env ruby

eqs = {}
ARGF.readlines.map(&:chomp).each do |line|
  res, vals = line.split(": ")
  vals = vals.split(" ").map(&:to_i)
  eqs[res.to_i] = vals
end

class Integer
  # 1 minute 16 seconds
  def concat_lame(a)
    "#{self}#{a}".to_i
  end
  # 1 minute 3 seconds, not much faster :(
  def concat(a)
    self * 10 ** (Math.log10(a).floor+1) + a
  end
end

result = eqs.filter do |test,values|
  [:*, :+, :concat].repeated_permutation(values.size-1).map do |oper|
    values[1..-1].each.with_index.reduce(values[0]) do |s, (x, i)|
      s.send(oper[i], x)
    end 
  end.any? { |k| k == test }
end

p result.keys.sum
