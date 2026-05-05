# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveset/vertical_sliding_movement'

# a pawn piece
class Pawn < Piece
  include Sliding

  def initialize(player, board)
    graphic = 'P'
    @forward = player.is_white ? 1 : -1

    super(player, board, graphic)
  end

  # paths
  # Returns an array of all valid nodes that this piece could move to
  def paths
    valid_vertical_nodes
  end

  private

  # returns true if this pawn is still in its initial position
  def first_move?
    node.row == @player.is_white ? 1 : (Grid::HEIGHT - 2)
  end

  def valid_vertical_nodes
    # get the path for the pawn and allow it to move a distance of 2 on the first move
    path_array = vertical_nodes(@board, node, @forward, first_move? ? 2 : 1)

    return path_array if path_array.empty?

    # remove last node if it is occuppied by either the same player or the oppossing player
    # (Pawn cannot kill the oppossing player by moving forward)
    path_array.pop if path_array.last.full?

    path_array
  end
end
