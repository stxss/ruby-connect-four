require_relative("slot")
class Board
  attr_accessor :grid, :first_player, :second_player, :winner

  def initialize
    slot = Slot.empty
    @grid = Array.new(6) { Array.new(7, slot) }
  end

  def create_scoreboard(player1, player2)
    @first_player = player1
    @second_player = player2
    @winner = nil
  end

  def show_board
    if RUBY_PLATFORM =~ /win32/ || RUBY_PLATFORM =~ /mingw/
      system("cls")
    else
      system("clear")
    end

    puts "\n" + scoreboard + "\n\n"
    @grid.map { |row| puts "                      #{row_join(row)}| \n #{splitter}" }
    puts "                        1   2   3   4   5   6   7  "
    puts "\n"
  end

  def has_winner?(checkpoint)
    @checkpoint = checkpoint
    is_winner = v_win? || h_win? || d_win?
    if is_winner
      @winner = @current_player
    end

    is_winner
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
    return false if @checkpoint.first > 2
    # top right bottom left || top left bottom right
    rl_win? || lr_win?
  end

  def rl_win?
    sequences = []
    4.times do |i|
      if @grid[@checkpoint.first + i]
        sequences << @grid[@checkpoint.first + i][@checkpoint.last - i]
      end
    end

    (!sequences.any?(Slot.empty) && sequences.size == 4 && sequences.uniq.count == 1)
  end

  def lr_win?
    sequences = []
    4.times do |i|
      if @grid[@checkpoint.first + i]
        sequences << @grid[@checkpoint.first + i][@checkpoint.last + i]
      end
    end

    (!sequences.any?(Slot.empty) && sequences.size == 4 && sequences.uniq.count == 1)
  end

  def row_join(row)
    row.map { |element| "| #{element} " }.join
  end

  def splitter
    "                     +" + "---+" * 7
  end

  def scoreboard
    <<~HEREDOC
      #{"+--------SCOREBOARD--------+".center(72)}
      #{"#{Slot.yellow} #{@first_player.name} - #{@first_player.score}".center(94)}
      #{"#{Slot.blue} #{@second_player.name} - #{@second_player.score}".center(94)}
      #{"+--------------------------+".center(72)}
    HEREDOC
  end
end
