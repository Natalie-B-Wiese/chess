# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/sliding'

# a bishop piece
class Bishop < Piece
  include Sliding

  def initialize(player, board)
    graphic = 'B'

    super(player, board, graphic)
  end

  def paths
    start_node = node
    valid_positive_slope(start_node) + valid_negative_slope(start_node)
  end

  private

  def valid_positive_slope(start_node)
    valid_positive_right_slope(start_node) + valid_positive_left_slope(start_node)
  end

  def valid_negative_slope(start_node)
    valid_negative_right_slope(start_node) + valid_negative_left_slope(start_node)
  end

  # a slope going up to the right
  def valid_positive_right_slope(start_node)
    path_array = diagonal_nodes(@board, start_node, 1, 1)
    validated_path_array(path_array, start_node)
  end

  # a slope going down to the left
  def valid_positive_left_slope(start_node)
    path_array = diagonal_nodes(@board, start_node, -1, -1)
    validated_path_array(path_array, start_node)
  end

  # a slope going down to the right
  def valid_negative_right_slope(start_node)
    path_array = diagonal_nodes(@board, start_node, 1, -1)
    validated_path_array(path_array, start_node)
  end

  # a slope going up to the left
  def valid_negative_left_slope(start_node)
    path_array = diagonal_nodes(@board, start_node, -1, 1)
    validated_path_array(path_array, start_node)
  end

  def validated_path_array(path_array, start_node)
    return path_array if path_array.empty?

    # remove last node if it is occuppied by same player
    path_array.pop if path_array.last.same_player?(start_node)

    path_array
  end
end
