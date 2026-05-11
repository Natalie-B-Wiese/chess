require_relative 'piece'

require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'

# for converting between letters and a piece class
module PieceConversion
  PIECE_TYPES = {
    'B' => Bishop,
    'K' => King,
    'N' => Knight,
    'P' => Pawn,
    'Q' => Queen,
    'R' => Rook
  }

  # converts a string letter into a class
  def self.letter_to_piece_type(letter)
    PIECE_TYPES[letter]
  end

  # converts a piece type into its letter
  def self.piece_type_to_letter(piece_type)
    PIECE_TYPES.invert[piece_type]
  end
end
