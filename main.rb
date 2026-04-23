require_relative 'lib/game'
require_relative 'lib/player'
# create a game, players, and play the game
player1 = Player.new('White Player')
player2 = Player.new('Black Player')

game = Game.new(player1, player2)

game.board.draw_board
