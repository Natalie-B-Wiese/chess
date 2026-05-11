# frozen-string-literal: true

require_relative '../terminal/terminal'
require_relative 'command'

# prints a list of pieces
class PiecesCommand < Command
  def self.execute
    content_array = [
      'R - Rook',
      'B - Bishop',
      'N - Knight',
      'K - King',
      'Q - Queen',
      'P - Pawn'
    ]

    Terminal.create_info_box('PIECES:', content_array, 20)
  end
end
