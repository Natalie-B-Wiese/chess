# frozen-string-literal: true

require_relative 'piece'
# a king piece
class King < Piece
  def initialize(player, board)
    graphic = 'K'
    super(player, board, graphic)
  end
end
