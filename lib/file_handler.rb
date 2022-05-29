# frozen_string_literal: true

# Class to handle files
class FileHandler
  def self.random_word
    lines = File.readlines('dict.txt')
    words = []
    lines.each do |line|
      next unless line.length.between?(5, 12)

      words.push(line)
    end

    words[rand(0..words.length - 1)]
  end

  def self.save_game(_content)
    File.open('./saves/test.txt', 'w') do |file|
      file.puts('word,num_of_guesses,current_guess,board_slots,incorrect_guesses')
      file.puts('test,4,0,_ _ _ _, ')
    end
  end

  def self.load_game
    lines = File.readlines('./saves/save.txt')

    content = []
    lines.each_with_index do |line, i|
      next if i == 0

      columns = line.split(',')
      content = columns
    end
    content # word,num_of_guesses,current_guess,board_slots,incorrect_guesses
  end
end
