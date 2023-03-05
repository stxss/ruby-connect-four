require_relative("player")

class Board
  attr_accessor :player1, :player2

  def initialize
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

  def verify_name(prev_name, input)
    if /^[a-zA-Z]+$/.match?(input) && input != prev_name
        input
    end
  end
end

# board = Board.new.create_players
