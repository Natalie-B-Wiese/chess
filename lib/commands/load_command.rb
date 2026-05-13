# frozen-string-literal: true

require_relative '../terminal/terminal'
require_relative 'command'
require_relative '../save_load/save_load_settings'
require_relative '../game'

# Loads a game and plays the loaded game
class LoadCommand < Command
  require 'fileutils'

  # Loads a game from a file and plays the loaded game
  def self.execute
    files = SaveLoadSettings.saved_files

    if files.empty?
      Terminal.print_error('There are no saved games. Load cancelled.')
    else
      show_loadable_files(files)

      path = valid_existing_filename
      if path.nil?
        Terminal.print_error('Load cancelled')
      else
        load_serialized_game(path).play_game
      end
    end
  end

  def self.show_loadable_files(files)
    content_array = []

    files.each do |filename|
      content_array.push(SaveLoadSettings.file_name_without_ext(filename))
    end

    Terminal.create_info_box('SAVED GAMES:', content_array, 40)
  end

  # returns a valid full path filename of a game that exists
  # Returns nil if user typed quit
  def self.valid_existing_filename
    loop do
      puts 'Load game... (or type QUIT to exit)'
      answer = gets.chomp
      return nil if answer.upcase == 'QUIT' || answer.length.zero?

      path = SaveLoadSettings.full_file_name(answer)

      return path if File.exist?(path)

      Terminal.print_error("There is no file named #{answer}. Choose a different name!")
    end
  end

  # Returns a Game object loaded from the data in the path
  def self.load_serialized_game(path)
    serialized_game = File.readlines(path).join("\n")

    game = Game.new
    game.unserialize(serialized_game)

    game
  end
end
