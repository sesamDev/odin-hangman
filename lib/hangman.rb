# frozen_string_literal: true

require_relative './file_manager'
# Class that stores all game logic
class Hangman
  include FileManager
  attr_accessor :word, :board_slots, :incorrect_guesses, :tries_left
  attr_reader :data

  def initialize
    @word = FileManager.random_word.chomp
    @board_slots = Array.new(word.length, '_ ')
    @incorrect_guesses = []
    @tries_left = word.length
    @data = { word: word,
              board_slots: board_slots,
              incorrect_guesses: incorrect_guesses,
              tries_left: tries_left }
  end

  def start_game
    puts 'Welcome to Hangman!'
    load_game?
    # init_board
    update_board
    fetch_tries_left
  end

  def loop_game
    play_round until game_over?
  end

  private

  def play_round
    guess = user_input
    puts ''
    update_board(guess)

    unless correct_guess?(guess)
      @data[:tries_left] -= 1
      data[:incorrect_guesses].push(guess)
    end

    fetch_tries_left
    save_game? unless data[:tries_left].zero?
  end

  def load_game?
    print 'Do you wish to load a saved game? Y/N: '
    puts
    return unless gets.chomp.downcase == 'y'

    loaded_data = FileManager.load_game
    loaded_data.each_key do |key|
      data[key] = loaded_data[key]
    end
  end

  def save_game?
    print 'Do you wish to save current game? Y/N: '
    puts
    FileManager.save_game(data) if gets.chomp.downcase == 'y'
  end

  def fetch_tries_left
    puts "Tries left: #{data[:tries_left]}"
    puts "Incorrect guesses: #{data[:incorrect_guesses].join(' ')}"
    puts ''
  end

  def update_board(guess = '')
    i = 0
    data[:word].each_char do |c|
      data[:board_slots][i] = c.upcase if c == guess
      i += 1
    end
    puts data[:board_slots].join(' ')
  end

  def user_input
    print 'Please enter your guess: '
    gets.chomp.downcase
  end

  def correct_guess?(guess)
    data[:word].include?(guess)
  end

  def game_over?
    return unless data[:board_slots].join('').downcase == data[:word] || data[:tries_left].zero?

    puts data[:tries_left].zero? ? 'You ran out of tries..' : 'Congratulations, you won!'
    exit
  end
end
