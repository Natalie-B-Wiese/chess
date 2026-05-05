# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/diagonal_sliding_movement'

# a bishop piece
class Bishop < Piece
  include DiagonalSlidingMovement

  def initialize(player, board)
    graphic = 'B'

    super(player, board, graphic)
  end

  def paths
    valid_diagonal_nodes
  end

  private

  def valid_diagonal_nodes
    start_node = node
    trim_friendly_endpoint(up_right_nodes(start_node), start_node) +
      trim_friendly_endpoint(up_left_nodes(start_node), start_node) +
      trim_friendly_endpoint(down_left_nodes(start_node), start_node) +
      trim_friendly_endpoint(down_right_nodes(start_node), start_node)
  end
end
