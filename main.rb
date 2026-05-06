require_relative 'lib/game'
require_relative 'lib/player'
require_relative 'lib/player_pieces'

# create a game, players, and play the game
player1 = Player.new('Player 1', true)
player2 = Player.new('Player 2', false)

puts "\e[31mThis is red\e[0m"
game = Game.new(player1, player2)

player1_pieces = PlayerPieces.new(player1, game.board)
player2_pieces = PlayerPieces.new(player2, game.board)

puts game.board.node_by_piece_type(King)

puts game.board.nodes_with_player_piece(player1)

game.play_game
