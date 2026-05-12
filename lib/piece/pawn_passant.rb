# frozen-string-literal: true

require_relative 'piece'
require_relative '../save_load/fen'

# a passant pawn is a copy of a pawn. It is an invisible piece that cannot be moved
# It is created by a pawn when a pawn moves two squares
# It is deleted after a full round (both players have gone)
class PawnPassant < Piece
  include Fen
  SYMBOL = 'E'

  def initialize(pawn_link, node_link)
    @piece_link = pawn_link
    @node_link = node_link
    super(pawn_link.is_white, SYMBOL)
  end

  def as_fen
    raise NotImplementedError, 'as_fen method not yet implemented in pawn passant'
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
