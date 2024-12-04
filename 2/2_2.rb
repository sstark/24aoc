#!/usr/bin/env ruby

class Array

  def reject_i(idx)
    return self.reject.each_with_index{|x,i|idx==i}
  end

  def reject_subsets
    ret = []
    self.size.times do |i|
      ret << self.reject_i(i)
    end
    return ret
  end

  def valid?
    self.all? { |x| [1,2,3].include? x } || self.all? { |x| [-1,-2,-3].include? x }
  end

  def deriv
    return self.each_cons(2).map {|y,z|y-z}
  end

end

m = ARGF.map { |x| x.split.map(&:to_i) }

n = 0
m.each do |line|
  if line.deriv.valid?
    n += 1
    next
  end 
  line.reject_subsets.each do |sub|
    if sub.deriv.valid?
      n += 1
      break
    end 
  end
end

puts n
