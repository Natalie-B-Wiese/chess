# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/diagonal_sliding_movement'

# a bishop piece
class Bishop < Piece
  include Sliding

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

  # Removes the last node from path_array if the last nodes's piece belongs to the same player as this piece
  # Note: it modifies the original array
  def trim_friendly_endpoint(path_array, start_node)
    return path_array if path_array.empty?

    # remove last node if it is occuppied by same player
    path_array.pop if path_array.last.same_player?(start_node)

    path_array
  end
end
