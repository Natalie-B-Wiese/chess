# frozen-string-literal: true

require_relative 'piece'

# a knight piece
class Knight < Piece
  def initialize(player, board)
    graphic = 'N'

    super(player, board, graphic)
  end
end
