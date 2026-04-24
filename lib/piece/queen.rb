# frozen-string-literal: true

require_relative 'piece'

# a queen piece
class Queen < Piece
  def initialize(player, board)
    graphic = player.is_white ? '&#9813;' : '&#9819;'

    super(player, board, graphic)
  end
end
