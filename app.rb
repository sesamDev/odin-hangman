lines = File.readlines('dict.txt')

words = []
lines.each do |line|
  next unless line.length.between?(5, 12)

  words.push(line)
end

puts words[rand(0..words.length - 1)]
