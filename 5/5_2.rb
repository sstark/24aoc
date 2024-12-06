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

# Lookup table page => following pages
all_rules = {}
rules.each do |rule|
  a, b = rule
  all_rules[a] = all_rules.fetch(a, []) << b
end

n = 0
good = false
updates.each do |update|
  rules.each do |rule|
    a, b = rule
    ia = update.index a
    ib = update.index b 
    next if ia == nil or ib == nil
    good = true
    if ia > ib
      good = false
      break
    end
  end
  if !good
    # comparison for sorting is done based on above lookup table
    # <=> also returns 0, but we do not need this here
    update.sort! { |a, b| all_rules.fetch(a, []).include?(b) ? -1 : 1 }
    n += update[update.size/2]
  end
end

puts n
