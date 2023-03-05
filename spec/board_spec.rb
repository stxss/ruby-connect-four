require_relative("../lib/board")

describe Board do
  describe "#create" do
    subject(:board) { described_class.new }

    context "when user inputs invalid name twice and then a valid input" do
      before do
        number = "111"
        symbol = "%"
        valid = "odin"
        allow(board).to receive(:gets).and_return(number, symbol, valid)
      end

      it "returns name asking message three times" do
        error_message = "Please, enter a valid name: "
        expect(board).to receive(:puts).with(error_message).exactly(3).times
        board.create
      end
    end

    context "when second user inputs same name as first" do
      subject(:board) { described_class.new }

      before do
        first = "odin"
        second = "odin"
        valid = "ruby"
        allow(board).to receive(:gets).and_return(first, second, valid)
      end

      it "returns name asking message three times" do
        first = "odin"
        error_message = "Please, enter a valid name: "
        expect(board).to receive(:puts).with(error_message).exactly(3).times
        board.create(first)
      end
    end
  end
end
