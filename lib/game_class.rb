require './stick_drawing'
class Game
  attr_accessor :word, :line_vector, :wrong_letters,:turns

  def initialize
    @word = File.readlines("google-10000-english-no-swears.txt", chomp: true)
    @unfiltered_word = filter(@word)
    @word = @unfiltered_word.sample
    @line_vector = Array.new(word.length, "_")
    @wrong_letters=[]
    @turns=0
  end

  def filter(words)
    words.select { |items| items.length.between?(6, 12) }
  end

  def add_lines
    @line_vector.join(" ")
  end

  def display_lines
    puts @line_vector.join(' ')
  end
  def put_letter
    gets.chomp.to_s.downcase
  end

  def check_letter(word, letter)
    word.include?(letter)
  end
  #get the indexes of the letters in the word
  def check_letter_position_s(letter)
    indexes = []
    @word.chars.each_with_index do |item, index| 
      indexes.push(index) if item == letter
    end
    indexes
  end
  #change the line array @line_vector with the correct letter
  def change_lines_to_letters(letter)
    letter_positions = check_letter_position_s(letter)

    letter_positions.each do |item|
      @line_vector[item] = letter
    end
  end

  def win?
    return true if @line_vector.join==@word
  end

  def draw_stick
    puts HANGMANSTICK[@turns]
  end
  
  def save_game(file_name)
    saves_path="/home/vboxuser/Desktop/proiecte/spanzuratoarea_optimised/lib/saved_files"
    unless Dir.exist?('saved_files')
      Dir.mkdir('saved_files')
    end
    file_path=File.join(saves_path,file_name)
    File.open(file_path,'wb') do |file|
      Marshal.dump({
        word:@word,
        line_vector:@line_vector,
        turns:@turns,
        wrong_letters:@wrong_letters
      },file)
    end
    puts "Game saved as:#{file_name}"
  end

  def load_save(file_name)
    if File.exist?(file_name)
      File.open(file_name,'rb') do |file|
        current_game_state=Marshal.load(file)
        @word=current_game_state[:word]
        @line_vector=current_game_state[:line_vector]
        @turns=current_game_state[:turns]
        @wrong_letters=current_game_state[:wrong_letters]
      end
      puts "Game: #{file_name} loaded!"
    end

  end

  def start_game
    option = 0
    while option != 1 && option != 2
      puts "1.New game"
      puts "2.Load a saved game"
      print "Your choice is:"
      option = gets.chomp.to_i
      puts

      if option== 1
        print "Name the current game for saving:"
        file_name=put_letter

        while !win?
          puts @word
          print "The letter do you want to chose:"
          input_letter = put_letter          
          
          puts
          puts "Save current progress"
          puts

          if input_letter=='save'
            save_game(file_name)
            break
          end

          if check_letter(@word,input_letter)  
            change_lines_to_letters(input_letter)
            display_lines
          else
            puts "AI gresit litera sefu!"
            @wrong_letters.push(input_letter)
            @turns+=1
            draw_stick

            puts "The wrong letters are:#{@wrong_letters}"
          end

          if win?
            puts "Felicitari! Ai castigat!"
            break
          elsif @turns>=6
            puts "Ai pierdut!"
            break
          end
        end
      elsif option==2
        
      end
    end
  end
end
