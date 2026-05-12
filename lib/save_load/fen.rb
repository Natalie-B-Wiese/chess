# frozen-string-literal: true

# a class for converting data to a string format
module Fen
  def as_fen
    raise NotImplementedError, "as_fen method must be implemented in class #{self.class.name}"
  end
end
