# frozen-string-literal: true

class Player
  # variables:
  # name

  attr_reader :name, :is_white

  def initialize(name, is_white)
    @name = name
    @is_white = is_white
  end
end
