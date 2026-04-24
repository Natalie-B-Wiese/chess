# frozen-string-literal: true

require_relative 'piece'

# a rook piece
class Rook < Piece
  def initialize(player, board)
    graphic = player.is_white ? '&#9814;' : '&#9820;'

    super(player, board, graphic)
  end
end
