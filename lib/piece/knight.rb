# frozen-string-literal: true

# a knight piece
class Knight < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9816;' : '&#9822;'

    super(player, board, graphic)
  end
end
