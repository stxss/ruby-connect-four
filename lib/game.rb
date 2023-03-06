require_relative("board")
require_relative("player")

class Game
  attr_accessor :player1, :player2, :board

  def initialize
    @board = Board.new
    @turn = 0
  end

  def play
    create_players
    @board.create_scoreboard(@player1, @player2)
    loop do
      spot = ask_play
      verified_spot = verify_position(spot)
      @turn += 1
      place(verified_spot - 1)
      @board.show_board
    end
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

  def ask_play
    loop do
      puts "Please, enter a valid position [1-7] to place your piece: "
      input = gets.chomp.to_i
      verified = verify_position(input)
      return verified if verified
    end
  end

  private

  def verify_name(prev_name, input)
    input if /^[a-zA-Z]+$/.match?(input) && input != prev_name
  end

  def verify_position(input)
    input if input.between?(1, 7)
  end

  def place(column)
    @current_player_chip = @turn.odd? ? Slot.yellow : Slot.blue

    board = @board.grid

    5.downto(0) do |row|
      if board[row][column] == Slot.empty
        board[row][column] = @current_player_chip
        break
      elsif board[0][column] != Slot.empty
        break
      else
        next
      end
    end
  end
end
