require_relative 'piece'

# a passant pawn is a copy of a pawn. It is an invisible piece that cannot be moved
# It is created by a pawn when a pawn moves two squares
# It is deleted after a full round (both players have gone)
class PawnPassant < Piece
  def initialize(pawn_link, node_link)
    @piece_link = pawn_link
    @node_link = node_link
    symbol = 'E'

    super(pawn_link.is_white, symbol)
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
