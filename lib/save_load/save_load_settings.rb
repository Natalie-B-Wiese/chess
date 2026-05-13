# frozen-string-literal: true

# holds info about where save files will be stored
module SaveLoadSettings
  require 'fileutils'

  SAVE_DIR = 'save_data'
  EXT = '.txt'

  # returns an array of files that have been saved
  def self.saved_files
    if File.directory?(SAVE_DIR) == false || Dir.children(SAVE_DIR).empty?
      []
    else
      Dir.children(SAVE_DIR)
    end
  end

  # creates the folder to save files in if it doesn't exist
  # Then returns the path to the file with the specified filename
  # Note: omit the EXT when passing it to this method
  def self.full_file_name(filename)
    FileUtils.mkdir_p(SAVE_DIR) unless File.directory?(SAVE_DIR)
    File.join(SAVE_DIR, filename + EXT)
  end

  # returns the name of a file without its path
  def self.file_name_without_path(filename)
    # index 0 of File.split is always the full path while index 1 is always the name of the file
    File.split(filename)[1]
  end

  # returns a filename without the extension
  def self.file_name_without_ext(filename)
    filename.delete_suffix(EXT)
  end
end
