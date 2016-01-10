require_relative '../../lib/command_runner'

describe CommandRunner do
  let (:robot) { Robot.new(0, 0, :north) }
  let(:board) { Board.new(5,5) }
  let(:command_runner) { CommandRunner.new(board) }
  let (:commands) { %Q{place(0, 0, :north)} }

  describe '#initialize' do
    it 'creates an object of command runner with instance variables' do
      cr = CommandRunner.new(board)
      expect(cr).to be_a_kind_of(CommandRunner)
    end
  end

  describe '#method_missing' do
    it 'does not run a command if the robot has not been placed' do
      expect(command_runner.robot).to be_nil

      command_runner.move
      command_runner.report

      expect(command_runner.robot).to be_nil
    end

    it 'creates an instance of the robot if the place command is run' do
      cmds = {'place' => ['0','0','north']}

      expect(command_runner.robot).to be_nil

      command_runner.place('0', '0', 'north')

      expect(command_runner.robot).to be_a_kind_of(Robot)
      expect(command_runner.robot.x_position).to eq(0)
      expect(command_runner.robot.y_position).to eq(0)
      expect(command_runner.robot.direction).to eq(:north)
    end

    context 'with a placed robot' do
      before(:each) do
        command_runner.place(0, 0, :north)
      end

      it 'runs a command if the robot' do
        command_runner.move(2)

        expect(command_runner.robot.y_position).to eq(2)
      end

      it 'moves the robot one space if move is called with no arguments' do
        command_runner.move

        expect(command_runner.robot.y_position).to eq(1)
      end

      it 'writes to STDOUT if the report command is executed' do
        expect(STDOUT).to receive(:puts).with('0,0,north')

        command_runner.report
      end

      it 'can turn the robot left' do
        command_runner.left

        expect(command_runner.robot.direction).to be(:west)
      end

      it 'can turn a robot right' do
        command_runner.right

        expect(command_runner.robot.direction).to be(:east)
      end
    end
  end

  describe '#respond_to_missing?' do
    it 'is true if the there is a method that matches the convention' do
      expect(command_runner.respond_to? :place).to be_truthy
    end

    it 'returns false if the argument does not match the convention' do
      expect(command_runner.respond_to? :dance).to be_falsey
    end
  end
end