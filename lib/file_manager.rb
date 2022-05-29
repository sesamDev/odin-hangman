# frozen_string_literal: true

require 'yaml'
# File manager functions
module FileManager
  def self.random_word
    lines = File.readlines('dict.txt')
    words = []
    lines.each do |line|
      next unless line.length.between?(5, 12)

      words.push(line)
    end

    words[rand(0..words.length - 1)]
  end

  def self.save_game(data)
    File.open('./saves/save.yaml', 'w') do |file|
      file.puts(YAML.dump(data))
    end
  end

  def self.load_game
    data = File.read('./saves/save.yaml')
    YAML.load data # Safe load not working with symbols
  end
end
