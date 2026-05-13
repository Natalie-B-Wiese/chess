require_relative 'piece'
require_relative 'moveable_piece'

require_relative '../terminal/terminal'
require_relative 'bishop'
require_relative 'knight'
require_relative 'queen'
require_relative 'rook'

# module that allows a piece to be converted to a different piece
module Promotable
  PIECE_TYPES = {
    Bishop::SYMBOL => Bishop,
    Knight::SYMBOL => Knight,
    Queen::SYMBOL => Queen,
    Rook::SYMBOL => Rook
  }

  # Promotes the piece at the node to a Bishop, Knight, Queen, or Rook
  def promote(piece, node)
    promote_type = Promotable::PIECE_TYPES[promote_type_input]
    puts "#{piece.class.name} has been promoted to a #{promote_type.name}"
    promoted_piece = promote_type.new(piece.is_white)
    node.replace_piece(promoted_piece)
  end

  private

  # returns true if the pawn is in a promotable spot, otherwise returns false

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
      puts "Promote #{self.class.name} to piece (R, B, N, or Q):"
      input = gets.chomp.upcase
      case input
      when 'R', 'B', 'N', 'Q'
        return input
      else
        Terminal.print_error('Invalid option! You must choose between R, B, N, or Q')
      end
    end
  end

  # return a valid letter string indiciating which piece to promote the pawn to
  def promote_type_input
    show_promotable_options
    puts "#{self.class.name} can be promoted to another piece."
    promote_type_prompt
  end
end
