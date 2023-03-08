require_relative("../lib/game")

describe Game do
  describe "#create" do
    subject(:game) { described_class.new }

    context "when user inputs invalid name twice and then a valid input" do
      before do
        number = "111"
        symbol = "%"
        valid = "odin"
        allow(game).to receive(:gets).and_return(number, symbol, valid)
      end

      it "returns name asking message three times" do
        ask_message = "Please, enter a valid name: "
        expect(game).to receive(:puts).with(ask_message).exactly(3).times
        game.create
      end
    end

    context "when second user inputs same name as first" do
      subject(:game) { described_class.new }

      before do
        first = "odin"
        second = "odin"
        valid = "ruby"
        allow(game).to receive(:gets).and_return(first, second, valid)
      end

      it "returns name asking message three times" do
        first = "odin"
        ask_message = "Please, enter a valid name: "
        expect(game).to receive(:puts).with(ask_message).exactly(3).times
        game.create(first)
      end
    end
  end

  describe "#ask_play" do
    context "player enters a correct place once" do
      subject(:game) { described_class.new }

      before do
        input = "2"
        allow(game).to receive(:gets).and_return(input)
      end

      it "returns input and doesn't display ask message at most once" do
        ask_message = "Please, enter a valid position [1-7] to place your piece: "
        expect(game).to receive(:puts).with(ask_message).at_most(:once)
        game.ask_play
      end
    end

    context "player enters an incorrect value twice, and then a correct value" do
      subject(:game) { described_class.new }

      before do
        string = "two"
        out_of_range = "9"
        valid = "2"
        allow(game).to receive(:gets).and_return(string, out_of_range, valid)
      end

      it "returns input and displays ask message at most three times" do
        ask_message = "Please, enter a valid position [1-7] to place your piece: "
        expect(game).to receive(:puts).with(ask_message).at_most(3).times
        game.ask_play
      end
    end
  end
end
