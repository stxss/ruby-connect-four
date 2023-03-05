require_relative("player")
require_relative("slot")

class Board
  attr_accessor :player1, :player2

  def initialize
    @board = nil
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
    @board.map { |row| puts "                #{row_join(row)}| \n #{splitter}"}
    puts "\n"
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
        #{"|#{@player1.name.rjust(12)} - #{@player1.score.to_s}".rjust(69)}          |
        #{"|#{@player2.name.rjust(12)} - #{@player2.score.to_s}".rjust(69)}          |
        #{"+--------------------------+".rjust(80)}
    HEREDOC
  end

  def verify_name(prev_name, input)
    if /^[a-zA-Z]+$/.match?(input) && input != prev_name
      input
    end
  end
end

board1 = Board.new
board1.create_players
board1.create_board
board1.show_board
