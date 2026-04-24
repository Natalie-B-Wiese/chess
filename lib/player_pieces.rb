require_relative 'piece/bishop'
require_relative 'piece/king'
require_relative 'piece/knight'
require_relative 'piece/pawn'
require_relative 'piece/queen'
require_relative 'piece/rook'

# holds an array of all pieces that a player needs
class PlayerPieces
  attr_reader :pieces

  def initialize(player, board)
    @pieces = []
    create_pieces(player, board)
  end

  def create_pieces(player, board)
    @pieces.push(King.new(player, board))
    @pieces.push(Queen.new(player, board))

    2.times do
      @pieces.push(Rook.new(player, board))
    end

    2.times do
      @pieces.push(Bishop.new(player, board))
    end

    2.times do
      @pieces.push(Knight.new(player, board))
    end

    8.times do
      @pieces.push(Pawn.new(player, board))
    end
  end
end
