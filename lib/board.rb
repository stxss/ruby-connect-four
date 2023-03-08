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
    @grid.map { |row| puts "                #{row_join(row)}| \n #{splitter}" }
    puts "                  1   2   3   4   5   6   7  "
    puts "\n"
  end

  def has_winner?(checkpoint)
    @checkpoint = checkpoint
    v_win? || h_win? || d_win?
  end

  private

  def v_win?
    return false if @checkpoint.first > 2

    new_arr = @grid.transpose.map(&:reverse)

    sequences = new_arr[@checkpoint.last].each_cons(4).to_a

    sequences.any? { |arr| arr.uniq.count == 1 && arr.size == 4 && !arr.any?(Slot.empty) }

    # Same result but a more "extensive/verbose approach"
    # check = []
    # 4.times do |i|
    #   check << @grid[@checkpoint.first + i][@checkpoint.last]
    # end

    # if check.any?(Slot.empty)
    #   false
    # elsif check.size == 4 && check.uniq.count == 1
    #   true
    # end
  end

  def h_win?
    sequences = @grid[@checkpoint.first].each_cons(4).to_a

    sequences.any? { |arr| arr.uniq.count == 1 && arr.size == 4 && !arr.any?(Slot.empty) }
  end

  def d_win?
  end

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
