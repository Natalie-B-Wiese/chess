# frozen-string-literal: true

require_relative 'piece'

# a queen piece
class Queen < Piece
  def initialize(player, board)
    graphic = 'Q'
    super(player, board, graphic)
  end
end
