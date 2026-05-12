# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/diagonal_sliding_movement'

# a bishop piece
class Bishop < Piece
  include DiagonalSlidingMovement

  def initialize(is_white_player)
    graphic = 'B'

    super(is_white_player, graphic)
  end

  def paths(start_node, board)
    valid_diagonal_nodes(start_node, board)
  end

  private

  def valid_diagonal_nodes(start_node, board)
    trim_friendly_endpoint(up_right_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(up_left_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(down_left_nodes(board, start_node), start_node) +
      trim_friendly_endpoint(down_right_nodes(board, start_node), start_node)
  end
end
