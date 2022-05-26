require 'pry-byebug'
lines = File.readlines('dict.txt')

def random_word(lines)
  words = []
  lines.each do |line|
    next unless line.length.between?(5, 12)

    words.push(line)
  end

  words[rand(0..words.length - 1)]
end

def init_board(word)
  word.each_char { print '_ ' }
  puts ''
end

def update_board(word, board_slots, guess = '')
  i = 0
  word.each_char do |c|
    board_slots[i] = c.upcase if c == guess
    i += 1
  end
  puts board_slots.join(' ')
end

def user_input
  print 'Please enter your guess: '
  gets.chomp.downcase
end

def correct_guess?(word, guess)
  word.include?(guess)
end

def game_over?(word, board_slots)
  return unless board_slots.join('').downcase == word

  puts 'Congratulations, you won!'
  exit
end

p word = random_word(lines).chomp # remove print when game finished
NUM_OF_GUESSES = word.length
current_guess = 0
board_slots = Array.new(word.length, '_ ')
incorrect_guesses = []

init_board(word)
while current_guess < NUM_OF_GUESSES
  guess = user_input
  puts ''
  update_board(word, board_slots, guess)

  unless correct_guess?(word, guess)
    current_guess += 1
    incorrect_guesses.push(guess)
  end

  puts "Tries left: #{word.length - current_guess}"
  puts "Incorrect guesses: #{incorrect_guesses.join(' ')}"
  puts ''
  game_over?(word, board_slots)
end

print 'You ran out of tries, wanna try again? Y/N:  '
gets.chomp
