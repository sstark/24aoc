#!/usr/bin/env ruby

rules = []
updates = []
ARGF.readlines.map(&:chomp).each do |line|
  if line[2] == "|"
    rules << line.split("|").map(&:to_i)
  elsif line != ""
    updates << line.split(",").map(&:to_i)
  end
end

n = 0
good = false
updates.each do |update|
  rules.each do |rule|
    a, b = rule
    ia = update.index a
    ib = update.index b 
    next if ia == nil or ib == nil
    if ia > ib
      good = false
      break
    else
      good = true
    end
  end
  if good
    n += update[update.size/2]
  end
end

puts n
