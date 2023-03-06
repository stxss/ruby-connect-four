require_relative("player")
require_relative("slot")

class Board
  attr_accessor :grid, :first_player, :second_player

  def initialize
    @board = nil
    @turn = 0
  end

  def create_board
    slot = Slot.empty
    @board = Array.new(6) { Array.new(7, slot) }
  end

  def create_players
    name1 = create
    name2 = create(name1)

    @player1 = Player.new(name1)
    @player2 = Player.new(name2)
  end

  def create(prev_name = nil)
    loop do
      puts "Please, enter a valid name: "
      input = gets.chomp
      verified = verify_name(prev_name, input)
      return verified if verified
    end
  end

  def show_board
    if RUBY_PLATFORM =~ /win32/ || RUBY_PLATFORM =~ /mingw/
      system("cls")
    else
      system("clear")
    end

    puts "\n" + scoreboard
    @board.map { |row| puts "                #{row_join(row)}| \n #{splitter}" }
    puts "                  1   2   3   4   5   6   7  "
    puts "\n"
  end

  def ask_play
    loop do
      puts "Please, enter a valid position [1-7] to place your piece: "
      input = gets.chomp.to_i
      verified = verify_position(input)
      place(verified) if verified
    end
  end

  private

  def row_join(row)
    row.map { |element| "| #{element} " }.join
  end

  def splitter
    "               +" + "---+" * 7
  end

  def scoreboard
    <<~HEREDOC
      #{"+--------SCOREBOARD--------+".rjust(80)}
      #{"|#{@player1.name.rjust(12)} - #{@player1.score}".rjust(69)}          |
      #{"|#{@player2.name.rjust(12)} - #{@player2.score}".rjust(69)}          |
      #{"+--------------------------+".rjust(80)}
    HEREDOC
  end

  def verify_name(prev_name, input)
    input if /^[a-zA-Z]+$/.match?(input) && input != prev_name
  end

  def verify_position(input)
    if input.between?(1, 7)
      @turn += 1
      place(input - 1)
    end
  end

  def place(column)
    @current_player_chip = @turn.odd? ? Slot.yellow : Slot.blue
    5.downto(0) do |row|
      if @board[row][column] == Slot.empty
        @board[row][column] = @current_player_chip
        show_board
        break
      elsif @board[0][column] != Slot.empty
        break
      else
        next
      end
    end
  end
end

board1 = Board.new
board1.create_players
board1.create_board
board1.show_board
board1.ask_play
