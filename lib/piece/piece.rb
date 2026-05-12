# frozen-string-literal: true

require_relative '../terminal/terminal_colors'
require_relative '../save_load/fen'

# An abstract class for a single chess piece or en pessant piece
class Piece
  include Fen
  attr_reader :is_white

  def initialize(is_white_player, symbol)
    @symbol = symbol
    @is_white = is_white_player
    @color = is_white_player ? TerminalColors::WHITE : TerminalColors::BLACK
  end

  # Each piece is identified by a single letter taken from the standard English names in algebraic notation.
  # White pieces are designated using uppercase letters ("PNBRQK"), while black pieces use lowercase letters ("pnbrqk")
  def as_fen
    str = @symbol
    if @is_white
      str.upcase
    else
      str.downcase
    end
  end

  def same_player?(other_piece)
    return false if other_piece.nil?

    @is_white == other_piece.is_white
  end

  # #to_s returns the piece's unique symbol
  def to_s
    "#{@color} #{@symbol} #{TerminalColors::RESET}"
  end
end
