#!/usr/bin/env ruby

left, right = ARGF.map(&:split).transpose
puts left.map {|e| right.tally.fetch(e, "0").to_i * e.to_i}.sum
