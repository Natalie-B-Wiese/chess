require_relative 'piece/bishop'
require_relative 'piece/king'
require_relative 'piece/knight'
require_relative 'piece/pawn'
require_relative 'piece/queen'
require_relative 'piece/rook'

# holds an array of all pieces that a player needs
class PlayerPieces
  attr_reader :pieces

  def initialize(player, board, is_white)
    @pieces = []
    create_pieces(player, board, is_white)
  end

  def create_pieces(player, board, is_white)
    @pieces.push(King.new(player, board, is_white))
    @pieces.push(Queen.new(player, board, is_white))

    2.times do
      @pieces.push(Rook.new(player, board, is_white))
    end

    2.times do
      @pieces.push(Bishop.new(player, board, is_white))
    end

    2.times do
      @pieces.push(Knight.new(player, board, is_white))
    end

    8.times do
      @pieces.push(Pawn.new(player, board, is_white))
    end
  end
end
