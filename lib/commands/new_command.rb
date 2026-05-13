# frozen-string-literal: true

require_relative 'command'
require_relative '../game'

# Creates and plays a new game
class NewCommand < Command
  require 'fileutils'

  # Plays a new game
  def self.execute
    game = Game.new
    game.board.load_from_fen('RNBQKBNR/PPPPPPPP/8/8/8/8/pppppppp/rnbqkbnr')
    game.play_game
  end
end
