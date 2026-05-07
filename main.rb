require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/player_pieces'

require_relative 'lib/terminal/terminal'

# create a game, players, and play the game
player1 = Player.new('Player 1', true)
player2 = Player.new('Player 2', false)

game = Game.new(player1, player2)

player1_pieces = PlayerPieces.new(player1, game.board)
player2_pieces = PlayerPieces.new(player2, game.board)

box_info = [
  'HELP - shows this help box',
  'PIECES - shows full names of pieces',
  'MOVES - show all available moves',
  'QUIT - exits the game without saving',
  'SAVE - save the games as a file'
]

Terminal.create_info_box('HELP:', box_info, 40)

game.play_game
