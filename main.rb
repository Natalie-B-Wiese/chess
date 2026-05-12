require_relative 'lib/game'

require_relative 'lib/terminal/terminal'
require_relative 'lib/user_input'

# create a new game and play the game
game = Game.new

# PlayerPieces creates all player pieces for a new game and sets up positioning for player pieces
# player1_pieces = PlayerPieces.new(true, game.board)
# player2_pieces = PlayerPieces.new(false, game.board)

puts game.board.as_fen

game.board.load_from_fen('RBNQBNBR/PPPPPPPP/8/8/8/8/pppppppp/rbnbqnbr')
puts game.board.as_fen

game.play_game
