# frozen-string-literal: true

require_relative 'command'
require_relative '../game'

# Creates and plays a new game
class NewCommand < Command
  require 'fileutils'

  # Plays a new game
  def self.execute
    game = Game.new
    game.board.load_from_fen('RNBQBBNR/PPPPPPPP/8/8/8/8/pppppppp/rnbbqbnr')
    game.play_game
  end
end
