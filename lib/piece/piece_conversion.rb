require_relative 'piece'
require_relative 'moveable_piece'

require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'

# for converting between letters and a piece class
module PieceConversion
  PIECE_TYPES = {
    Bishop::SYMBOL => Bishop,
    King::SYMBOL => King,
    Knight::SYMBOL => Knight,
    Pawn::SYMBOL => Pawn,
    Queen::SYMBOL => Queen,
    Rook::SYMBOL => Rook
  }

  # converts a string letter into a class
  def self.letter_to_piece_type(letter)
    PIECE_TYPES[letter]
  end

  # converts a piece type into its letter
  def self.piece_type_to_letter(piece_type)
    PIECE_TYPES.invert[piece_type]
  end

  # creates a new piece of the correct class based on the fen_str
  def self.from_fen(fen_str)
    is_white = (fen_str == fen_str.upcase)
    symbol = fen_str.upcase

    piece_type = letter_to_piece_type(symbol)
    raise ArgumentError, "Unknown FEN piece: #{fen_str}" unless piece_type

    letter_to_piece_type(symbol).new(is_white)
  end
end
