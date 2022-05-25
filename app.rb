lines = File.readlines('dict.txt')

def random_word(lines)
  words = []
  lines.each do |line|
    next unless line.length.between?(5, 12)

    words.push(line)
  end

  words[rand(0..words.length - 1)]
end

def update_board(word, guess)
  word.each_char do |c|
    print "#{guess.upcase} " if c == guess
    print '_ '
  end
  puts ''
end

# incorrect_guesses = []
# def display_incorrect_guess(guess)
#   incor
# end

p word = random_word(lines) # remove print when game finished

guess = gets.chomp
update_board(word, guess)
