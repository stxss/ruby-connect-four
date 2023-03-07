require_relative("../lib/board")

describe Board do
  describe "#has_winner?" do
    subject(:check) { described_class.new }
    let(:grid) { check.instance_variable_get(:@grid) }

    context "there's been a vertical win" do
      before do
        grid[2][0] = Slot.yellow
        grid[3][0] = Slot.yellow
        grid[4][0] = Slot.yellow
        grid[5][0] = Slot.yellow
      end

      it "returns true and prints a message congratulating the winner" do
        checkpoint = [2, 0]
        result = check.has_winner?(checkpoint)
        expect(result).to eq(true)
      end
    end

    context "there's not been a vertical win" do
      before do
        grid[2][0] = Slot.yellow
        grid[3][0] = Slot.blue
        grid[4][0] = Slot.yellow
        grid[5][0] = Slot.yellow
      end

      it "returns nil" do
        checkpoint = [2, 0]
        result = check.has_winner?(checkpoint)
        expect(result).to be_nil
      end
    end

    context "there's been a horizontal win" do
        before do
          grid[1][2] = Slot.yellow
          grid[1][3] = Slot.yellow
          grid[1][4] = Slot.yellow
          grid[1][5] = Slot.yellow
        end

        it "returns true and prints a message congratulating the winner" do
          checkpoint = [1, 4]
          result = check.has_winner?(checkpoint)
          expect(result).to eq(true)
        end
      end

      context "there's not been a horizontal win" do
        before do
          grid[1][2] = Slot.yellow
          grid[1][3] = Slot.yellow
          grid[1][4] = Slot.blue
          grid[1][5] = Slot.yellow
        end

        it "returns nil" do
          checkpoint = [1, 3]
          result = check.has_winner?(checkpoint)
          expect(result).to be_nil
        end
      end
  end
end
