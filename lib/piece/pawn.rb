# frozen-string-literal: true

require_relative 'piece'

# a pawn piece
class Pawn < Piece
  def initialize(player, board)
    graphic = 'P'

    super(player, board, graphic)
  end
end
