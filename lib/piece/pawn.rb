# frozen-string-literal: true

require_relative 'piece'
require_relative 'moveable_piece'

require_relative 'moveset/vertical_sliding_movement'
require_relative 'moveset/diagonal_sliding_movement'
require_relative '../board/grid_settings'
require_relative '../terminal/terminal'

# a pawn piece
class Pawn < MoveablePiece
  include VerticalSlidingMovement
  include DiagonalSlidingMovement
  SYMBOL = 'P'

  def initialize(is_white_player)
    @forward = is_white_player ? 1 : -1

    super(is_white_player, SYMBOL)
  end

  # paths
  # Returns an array of all valid nodes that this piece could move to
  def paths(start_node, board)
    valid_vertical_nodes(start_node, board) + valid_diagonal_nodes(start_node, board)
  end

  # returns true if the pawn is in a promotable spot, otherwise returns false
  def promotable?(node)
    (@forward == 1 && node.row == GridSettings::HEIGHT - 1) || (@forward == -1 && node.row == 0)
  end

  # return a valid letter string indiciating which piece to promote the pawn to
  def promote_type_input
    show_promotable_options
    puts 'Pawn has reached the other side! It can be promoted to another piece.'
    promote_type_prompt
  end

  private

  def show_promotable_options
    content_array = [
      'R - Rook',
      'B - Bishop',
      'N - Knight',
      'Q - Queen'
    ]

    Terminal.create_info_box('PIECES:', content_array, 20)
  end

  # prompts user for the type of piece to promote pawn to
  # It returns a valid letter option (R, B, N, or Q)
  def promote_type_prompt
    loop do
      puts 'Promote pawn to piece (R, B, N, or Q): '
      input = gets.chomp.upcase
      case input
      when 'R', 'B', 'N', 'Q'
        return input
      else
        Terminal.print_error('Invalid option! You must choose between R, B, N, or Q')
      end
    end
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
