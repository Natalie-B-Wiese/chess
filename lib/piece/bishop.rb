# frozen-string-literal: true

require_relative 'piece'

# a bishop piece
class Bishop < Piece
  def initialize(player, board)
    graphic = 'B'

    super(player, board, graphic)
  end
end
