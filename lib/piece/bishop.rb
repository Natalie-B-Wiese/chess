# frozen-string-literal: true

# a bishop piece
class Bishop < Piece
  def initialize(player, board, is_white)
    graphic = is_white ? '&#9815;' : '&#9821;'

    super(player, board, graphic)
  end
end
