require_relative("slot")
class Board
  attr_accessor :grid, :first_player, :second_player

  def initialize
    slot = Slot.empty
    @grid = Array.new(6) { Array.new(7, slot) }
  end

  def create_scoreboard(player1, player2)
    @first_player = player1
    @second_player = player2
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
      #{"|#{@first_player.name.rjust(12)} - #{@first_player.score}".rjust(69)}          |
      #{"|#{@second_player.name.rjust(12)} - #{@second_player.score}".rjust(69)}          |
      #{"+--------------------------+".rjust(80)}
    HEREDOC
  end
end
