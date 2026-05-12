# frozen-string-literal: true

require_relative '../terminal/terminal_colors'

# An abstract class for a single chess piece or en pessant piece
class Piece
  attr_reader :is_white

  def initialize(is_white_player, symbol)
    @symbol = symbol
    @is_white = is_white_player
    @color = is_white_player ? TerminalColors::WHITE : TerminalColors::BLACK
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
