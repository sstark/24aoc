#!/usr/bin/env ruby

m = ARGF.readlines
mul = /mul\([0-9]+,[0-9]+\)/
enable = /do\(\)/
disable = /don't\(\)/
tokens = Regexp.union([mul, enable, disable])
nums = /[0-9]+,[0-9]+/

n = 0
enabled = true
m.each do |line|
  line.scan(tokens).each do |tok|
    case tok
    when enable
      enabled = true
    when disable
      enabled = false
    when mul
      if enabled
        a, b = tok.scan(nums)[0].split(',').map(&:to_i)
        n += a*b
      end
    end
  end
end

puts n
