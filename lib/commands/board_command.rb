# frozen-string-literal: true

require_relative 'command'
require_relative '../board/grid_drawer'

# draws the board in the terminal
class BoardCommand < Command
  def self.execute(game)
    GridDrawer.draw(game.board)
  end
end
