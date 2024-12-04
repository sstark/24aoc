#!/usr/bin/env ruby

m = ARGF.map { |x| x.split.map(&:to_i) }
inc = m.map { |x| x.each_cons(2).map {|y,z|y-z} }
class Array
  def valid?
    self.all? { |x| [1,2,3].include? x } || self.all? { |x| [-1,-2,-3].include? x }
  end
end
puts inc.select(&:valid?).size
