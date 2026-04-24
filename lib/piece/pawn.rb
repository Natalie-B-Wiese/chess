# frozen-string-literal: true

require_relative 'piece'

# a pawn piece
class Pawn < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9817;' : '&#9823;'

    super(player, board, graphic)
  end
end
