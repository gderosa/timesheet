#!/usr/bin/env ruby

require 'date'

class Date
  def weekend?
    saturday? or sunday?
  end
end

begin
  d = Date.parse ARGV.join ' '
rescue ArgumentError
  d = Date.parse Date.today.strftime "%Y-%m-01" # this month
end

m = d.month

while (d.month == m) do
  if d.weekend?
    puts
  else
    puts d
    puts d
    puts
  end
  d += 1
end



