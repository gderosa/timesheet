require 'date'

class Date
  def weekend?
    saturday? or sunday?
  end
end
