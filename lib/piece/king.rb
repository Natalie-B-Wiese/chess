# frozen-string-literal: true

# a king piece
class King < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9812;' : '&#9818;'

    super(player, board, graphic)
  end
end
