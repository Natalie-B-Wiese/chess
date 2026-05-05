# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/horizontal_sliding_movement'
require_relative 'moveset/vertical_sliding_movement'

# a rook piece
class Rook < Piece
  include HorizontalSlidingMovement
  include VerticalSlidingMovement

  def initialize(player, board)
    graphic = 'R'
    super(player, board, graphic)
  end

  def paths
    valid_vertical_nodes + valid_horizontal_nodes
  end

  private

  def valid_vertical_nodes
    start_node = node
    trim_friendly_endpoint(vertical_nodes(@board, start_node, 1), start_node) +
      trim_friendly_endpoint(vertical_nodes(@board, start_node, -1), start_node)
  end

  def valid_horizontal_nodes
    start_node = node
    trim_friendly_endpoint(horizontal_nodes(@board, start_node, 1), start_node) +
      trim_friendly_endpoint(horizontal_nodes(@board, start_node, -1), start_node)
  end
end
