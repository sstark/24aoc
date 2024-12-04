#!/usr/bin/env ruby

left, right = ARGF.map(&:split).transpose
freqs = Hash[right.group_by{|x|x}.map{|k, v| [k.to_i, v.size]}]
puts left.map {|e| freqs.fetch(e.to_i, 0) * e.to_i}.sum
