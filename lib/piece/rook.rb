# frozen-string-literal: true

require_relative 'piece'

# a rook piece
class Rook < Piece
  def initialize(player, board)
    graphic = 'R'
    super(player, board, graphic)
  end
end
