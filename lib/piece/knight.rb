# frozen-string-literal: true

require_relative 'piece'

# a knight piece
class Knight < Piece
  def initialize(player, board)
    graphic = player.is_white ? '&#9816;' : '&#9822;'

    super(player, board, graphic)
  end
end
