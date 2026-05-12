# a passant pawn is a copy of a pawn. It is an invisible piece that cannot be moved
# It is created by a pawn when a pawn moves two squares
# It is deleted after a full round (both players have gone)
class PawnPassant
  attr_reader :player, :has_moved, :is_white

  def initialize(pawn_link, node_link)
    @piece_link = pawn_link
    @node_link = node_link
    @has_moved = false

    @is_white = pawn_link.is_white

    @color = @is_white ? TerminalColors::WHITE : TerminalColors::BLACK
    @has_moved = false
  end

  # methods:
  # #to_s returns the piece's unique symbol
  def to_s
    "#{@color}PeP#{TerminalColors::RESET}"
  end

  def same_player?(other_piece)
    return false if other_piece.nil?

    @is_white == other_piece.is_white
  end

  def valid_move?(start_node, board)
    false
  end

  # kills the linked piece and returns the piece that was killed
  def kill_linked_piece
    puts "#{@piece_link.class} was killed via en passant"
    @node_link.remove_piece
    @piece_link
  end

  def undo_kill_linked_piece
    puts 'Undoing en passant'
    @node_link.set_initial_piece(@piece_link)
  end
end
