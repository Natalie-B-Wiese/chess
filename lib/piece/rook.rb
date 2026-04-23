# frozen-string-literal: true

# a rook piece
class Rook < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9814;' : '&#9820;'

    super(player, board, graphic)
  end
end
