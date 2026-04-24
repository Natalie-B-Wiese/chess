# frozen-string-literal: true

require_relative 'piece'

# a bishop piece
class Bishop < Piece
  def initialize(player, board)
    graphic = player.is_white ? '&#9815;' : '&#9821;'

    super(player, board, graphic)
  end
end
