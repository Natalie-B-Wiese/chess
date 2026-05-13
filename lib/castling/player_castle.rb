require_relative 'castling_settings'
require_relative 'castle'

require_relative '../save_load/fen'

# holds castling data for a player
class PlayerCastle
  include Fen
  def initialize(board, is_white)
    row = is_white ? 0 : 7

    @queenside = Castle.new(board, row, is_white, CastlingSettings::QUEENSIDE_ROOK_COLUMN, 'Q')
    @kingside = Castle.new(board, row, is_white, CastlingSettings::KINGSIDE_ROOK_COLUMN, 'K')
  end

  # Q means castling is possible queenside
  # K means castling is possible kingside
  # QK means castling is possible both king and queenside
  # - means castling is impossible
  def as_fen
    fen_str = @queenside.as_fen + @kingside.as_fen
    fen_str = '-' if fen_str == ''
    fen_str
  end

  def load_from_fen(fen_str)
    @queenside.load_from_fen(fen_str)
    @kingside.load_from_fen(fen_str)
  end

  def try_castle_from_input(castle_side)
    case castle_side
    when 'CQ'
      try_castle(@queenside)
    when 'CK'
      try_castle(@kingside)
    else
      false
    end
  end

  private

  # attempts to preform a castle.
  # Returns true if successful, false if castle cannot be preformed
  # Prevents all castling if castle is preformed
  def try_castle(side)
    return false unless side.castle_possible?

    # player can no longer castle
    @queenside.prevent_castling
    @kingside.prevent_castling

    side.preform_castle
    true
  end
end
