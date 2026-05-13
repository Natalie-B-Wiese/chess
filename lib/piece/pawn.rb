# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveable_piece'

require_relative 'moveset/vertical_sliding_movement'
require_relative 'moveset/diagonal_sliding_movement'
require_relative '../board/grid_settings'
require_relative '../terminal/terminal'

require_relative 'promotable'
require_relative 'pawn_passant'

# a pawn piece
class Pawn < MoveablePiece
  include VerticalSlidingMovement
  include DiagonalSlidingMovement
  include Promotable

  SYMBOL = 'P'

  def initialize(is_white_player)
    @forward = is_white_player ? 1 : -1

    super(is_white_player, SYMBOL)
  end

  # applies additional special logic when a pawn moves
  def confirm_move(board)
    promote(self, @goal_node) if promotable?

    # if the pawn moved two squares, create a passant pawn
    create_passant_pawn(board) if (@goal_node.row - @start_node.row).abs == 2

    # this must be last since it clears the start_node, goal_node, and piece_killed variables
    super(board)
  end

  # paths
  # Returns an array of all valid nodes that this piece could move to
  def paths(start_node, board)
    valid_vertical_nodes(start_node, board) + valid_diagonal_nodes(start_node, board)
  end

  private

  def promotable?
    (@is_white && @goal_node.row == GridSettings.top_row) ||
      (@is_white == false && @goal_node.row == GridSettings.bottom_row)
  end

  # creates a passant pawn between start_node and goal_node (aka current node)
  def create_passant_pawn(board)
    mid_row = (@goal_node.row + @start_node.row) / 2
    mid_node = board.node_at_row_column(mid_row, @goal_node.column)
    passant = PawnPassant.new(@is_white)
    passant.setup_node_link(@goal_node)
    mid_node.set_initial_piece(passant)
  end

  def valid_vertical_nodes(start_node, board)
    # allow pawn to move 2 units if it has never moved before
    max_move_amount = @has_moved ? 1 : 2

    path_array = vertical_nodes(board, start_node, @forward, max_move_amount)

    return path_array if path_array.empty?

    # remove last node if it is occuppied by either the same player or the oppossing player
    # (Pawn cannot kill the oppossing player by moving forward)
    path_array.pop if path_array.last.full?

    path_array
  end

  # gets nodes that are diagonal to this pawn and are occuppied by an opposing piece
  def valid_diagonal_nodes(start_node, board)
    diagonal_nodes(start_node, board).select do |n|
      !n.nil? && (n.contains_passant? || n.full?) && !n.same_player?(start_node)
    end
  end

  def diagonal_nodes(start_node, board)
    if @forward == 1
      up_right_nodes(board, start_node, 1) + up_left_nodes(board, start_node, 1)
    else
      down_right_nodes(board, start_node, 1) + down_left_nodes(board, start_node, 1)
    end
  end
end
