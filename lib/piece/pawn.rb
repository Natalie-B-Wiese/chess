# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/vertical_sliding_movement'
require_relative 'moveset/diagonal_sliding_movement'

# a pawn piece
class Pawn < Piece
  include VerticalSlidingMovement
  include DiagonalSlidingMovement

  def initialize(player, board)
    graphic = 'P'
    @forward = player.is_white ? 1 : -1

    super(player, board, graphic)
  end

  # paths
  # Returns an array of all valid nodes that this piece could move to
  def paths
    valid_vertical_nodes + valid_diagonal_nodes
  end

  private

  def valid_vertical_nodes
    # allow pawn to move 2 units if it has never moved before
    max_move_amount = @has_moved ? 1 : 2

    path_array = vertical_nodes(@board, node, @forward, max_move_amount)

    return path_array if path_array.empty?

    # remove last node if it is occuppied by either the same player or the oppossing player
    # (Pawn cannot kill the oppossing player by moving forward)
    path_array.pop if path_array.last.full?

    path_array
  end

  # gets nodes that are diagonal to this pawn and are occuppied by an opposing piece
  def valid_diagonal_nodes
    start_node = node
    diagonal_nodes.reject do |n|
      n.nil? || !n.full? || n.same_player?(start_node)
    end
  end

  def diagonal_nodes
    start_node = node
    if @forward == 1
      up_right_nodes(@board, start_node, 1) + up_left_nodes(@board, start_node, 1)
    else
      down_right_nodes(@board, start_node, 1) + down_left_nodes(@board, start_node, 1)
    end
  end
end
