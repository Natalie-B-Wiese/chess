require_relative 'castling_settings'
require_relative '../save_load/fen'

class Castle
  include Fen
  attr_reader :castle_possible

  def initialize(board, row, is_white, rook_column, can_castle_symbol)
    @c_rook = rook_column
    @row = row
    @is_white = is_white

    @can_castle_symbol = can_castle_symbol

    @board = board

    # castle becomes impossible once the rook or king moves or once this player has castled
    @castle_possible = true

    # the direction the king moves for this castling type
    @king_direction = @c_rook < CastlingSettings::KING_COLUMN ? -1 : 1

    @king_start_node = @board.node_at_row_column(@row, CastlingSettings::KING_COLUMN)
    @king_goal_node = @board.node_at_row_column(@row, CastlingSettings::KING_COLUMN + (@king_direction * 2))

    @rook_start_node = @board.node_at_row_column(@row, @c_rook)
    @rook_goal_node = @board.node_at_row_column(@row, @king_goal_node.column - @king_direction)
  end

  def prevent_castling
    @castle_possible = false
  end

  def as_fen
    @castle_possible = false if rook_or_king_moved?
    @castle_possible == true ? @can_castle_symbol : ''
  end

  def load_from_fen(fen_str)
    @castle_possible = fen_str.include?(@can_castle_symbol)
  end

  # returns true if a castle is currently possible, false otherwise
  def castle_possible?
    return false unless @castle_possible == true

    # the king and rook cannot have moved
    return false if rook_or_king_moved?

    # All squares between the king and rook must be vacant
    return false unless nodes_between_vacant?

    # none of the nodes king visits during a castle can be in-check
    return false if king_squares_in_check?

    true
  end

  def preform_castle
    king = @king_start_node.piece
    rook = @rook_start_node.piece

    # preform the move for both pieces
    king.simulate_move(@king_start_node, @king_goal_node)
    king.confirm_move(@board)

    rook.simulate_move(@rook_start_node, @rook_goal_node)
    rook.confirm_move(@board)

    prevent_castling
  end

  private

  def rook_or_king_moved?
    king_moved? || rook_moved?
  end

  # returns true if the king has moved
  def king_moved?
    return true if @king_start_node.piece.is_a?(King) == false

    @king_start_node.piece.has_moved
  end

  # returns true if the rook has moved
  def rook_moved?
    return true if @rook_start_node.piece.is_a?(Rook) == false

    @rook_start_node.piece.has_moved
  end

  # returns true if all squares between the king and rook are vacant
  def nodes_between_vacant?
    c_min = [CastlingSettings::KING_COLUMN, @c_rook].min
    c_max = [CastlingSettings::KING_COLUMN, @c_rook].max
    c_between = ((c_min + 1)...c_max).to_a

    c_between.each do |c|
      return false if @board.node_at_row_column(@row, c).full?
    end
    true
  end

  # returns true if the king is in check, passes through a check, or lands in a check
  # (ie there are 3 tiles that cannot be in-check)
  def king_squares_in_check?
    king_check_column = CastlingSettings::KING_COLUMN
    3.times do
      king_visit_node = @board.node_at_row_column(@row, king_check_column)
      return true if @board.node_reachable_by_is_white_value?(king_visit_node, !@is_white)

      king_check_column += @king_direction
    end
    false
  end
end
