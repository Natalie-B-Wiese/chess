# frozen-string-literal: true

# a queen piece
class Queen < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9813;' : '&#9819;'

    super(player, board, graphic)
  end
end
