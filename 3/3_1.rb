#!/usr/bin/env ruby

m = ARGF.readlines
full_pat = /mul\([0-9]+,[0-9]+\)/
nums = /[0-9]+,[0-9]+/

n = 0
m.each do |line|
  line.scan(full_pat).each do |mul|
    a, b  = mul.scan(nums)[0].split(',').map(&:to_i)
    n += a*b
  end
end

puts n
