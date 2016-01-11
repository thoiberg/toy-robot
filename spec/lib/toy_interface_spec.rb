require_relative '../../lib/toy_interface'

describe ToyInterface do
  let (:robot) { Robot.new(0, 0, :north) }
  let(:board) { Board.new(5,5) }
  let(:toy_interface) { ToyInterface.new(board, robot) }
  let (:commands) { %Q{place(0, 0, :north)} }

  describe '#initialize' do
    it 'creates an object of command runner with instance variables' do
      cr = ToyInterface.new(board, robot)
      expect(cr).to be_a_kind_of(ToyInterface)
    end

    it 'raises an error if the robots starting position does not fit on the board' do
      bad_robot = Robot.new(100, 100, :north)
      expect{ ToyInterface.new(board, bad_robot) }.to raise_error(ArgumentError)
    end
  end

  describe '#move' do
    it 'moves the toy the set amount of spaces' do
      expect(toy_interface.toy.y_position).to eq(0)
      toy_interface.move

      expect(toy_interface.toy.y_position).to eq(1)
    end

    it 'does not move the toy if the new position is off the board' do
      expect(toy_interface.toy.y_position).to eq(0)
      toy_interface.move 100

      expect(toy_interface.toy.y_position).to eq(0)
    end
  end
  
  describe '#left' do
    it 'turns the toy to the left' do
      toy_interface.left
      expect(toy_interface.toy.direction).to be(:west)
    end
  end

  describe '#right' do
    it 'turns the toy to the right' do
      toy_interface.right
      expect(toy_interface.toy.direction).to be(:east)
    end
  end

  describe '#report' do
    it 'reports the toy data to STDOUT' do
      expect(STDOUT).to receive(:puts).once.with("0,0,north")
      toy_interface.report
    end
  end
end