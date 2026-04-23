# frozen-string-literal: true

require_relative 'board/grid'

# holds a game
class Game
  # player1 is the white player, and player2 is the black player
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2

    @board = Grid.new
  end
end
