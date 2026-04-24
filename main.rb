require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/player_pieces'

# create a game, players, and play the game
player1 = Player.new('Player 1', true)
player2 = Player.new('Player 2', false)

game = Game.new(player1, player2)

player1_pieces = PlayerPieces.new(player1, game.board)
player2_pieces = PlayerPieces.new(player2, game.board)

game.board.draw_board
