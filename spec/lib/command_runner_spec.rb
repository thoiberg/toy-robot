require_relative '../../lib/command_runner'

describe CommandRunner do
  let (:robot) { Robot.new(0, 0, :north) }
  let(:board) { Board.new(5,5) }
  let(:command_runner) { CommandRunner.new(board, robot) }
  let (:commands) { %Q{place(0, 0, :north)} }

  describe '#initialize' do
    it 'creates an object of command runner with instance variables' do
      cr = CommandRunner.new(board, robot)
      expect(cr).to be_a_kind_of(CommandRunner)
    end

    it 'raises an error if the robots starting position does not fit on the board' do
      bad_robot = Robot.new(100, 100, :north)
      expect{ CommandRunner.new(board, bad_robot) }.to raise_error(ArgumentError)
    end
  end

  describe '#move' do
    it 'moves the toy the set amount of spaces' do
      expect(command_runner.toy.y_position).to eq(0)
      command_runner.move

      expect(command_runner.toy.y_position).to eq(1)
    end

    it 'does not move the toy if the new position is off the board' do
      expect(command_runner.toy.y_position).to eq(0)
      command_runner.move 100

      expect(command_runner.toy.y_position).to eq(0)
    end
  end
  
  describe '#left' do
    it 'turns the toy to the left' do
      command_runner.left
      expect(command_runner.toy.direction).to be(:west)
    end
  end

  describe '#right' do
    it 'turns the toy to the right' do
      command_runner.right
      expect(command_runner.toy.direction).to be(:east)
    end
  end

  describe '#report' do
    it 'reports the toy data to STDOUT' do
      expect(STDOUT).to receive(:puts).once.with("0,0,north")
      command_runner.report
    end
  end
end