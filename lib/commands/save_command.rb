# frozen-string-literal: true

require_relative '../terminal/terminal'
require_relative 'command'
require_relative '../save_load/save_load_settings'

# Saves a game to a file of user's choice
class SaveCommand < Command
  require 'fileutils'

  # saves the game to a file
  # Doesn't do anything if user cancels
  def self.execute(game)
    filename = valid_new_filename

    if filename.nil?
      Terminal.print_error('Save cancelled')
    else
      serialized_game = game.serialize
      save_data_to_file(serialized_game, filename)
    end
  end

  # saves serialized data to a full path location
  def self.save_data_to_file(serialized_game, path)
    f = File.new(path, 'w')
    f.print serialized_game
    f.close
    puts "Successfully saved game as #{path}"
  end

  # returns a valid filename that does not overwrite another file
  # Returns nil if user typed back
  def self.valid_new_filename
    loop do
      puts 'Save game as... (or type BACK to cancel)'
      answer = gets.chomp
      return nil if answer.upcase == 'BACK' || answer.length.zero?

      path = SaveLoadSettings.full_file_name(answer)

      return path unless File.exist?(path)

      Terminal.print_error("There is already a game named #{answer}. Choose a different name!")
    end
  end
end
