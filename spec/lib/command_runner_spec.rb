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

  describe '#run_commands' do
    it 'does not run a command if the robot has not been placed' do
      cmds = {'move' => [], 'report' => []}

      expect(command_runner.robot).to be_nil

      command_runner.run_commands(cmds)

      expect(command_runner.robot).to be_nil
    end

    it 'creates an instance of the robot if the place command is run' do
      cmds = {'place' => [0,0,'north']}

      expect(command_runner.robot).to be_nil

      command_runner.run_commands(cmds)

      expect(command_runner.robot).to be_a_kind_of(Robot)
      expect(command_runner.robot.x_position).to eq(0)
      expect(command_runner.robot.y_position).to eq(0)
      expect(command_runner.robot.direction).to eq(:north)
    end

    context 'with a placed robot' do
      ## TODO: find a nicer way to stub this out
      let(:cmds) { {'place' => [0,0,'north']} }

      it 'runs a command if the robot' do
        cmds.update('move' => [2])

        command_runner.run_commands(cmds)

        expect(command_runner.robot.y_position).to eq(2)
      end

      it 'moves the robot one space if move is called with no arguments' do
        cmds.update('move' => [])

        command_runner.run_commands(cmds)

        expect(command_runner.robot.y_position).to eq(1)
      end

      it 'writes to STDOUT if the report command is executed' do
        expect(STDOUT).to receive(:puts).with('0,0,north')

        cmds.update('report' => [])
        command_runner.run_commands(cmds)
      end

      it 'can turn the robot left' do
        cmds.update('left' => [])
        command_runner.run_commands(cmds)

        expect(command_runner.robot.direction).to be(:west)
      end

      it 'can turn a robot right' do
        cmds.update('right' => [])
        command_runner.run_commands(cmds)

        expect(command_runner.robot.direction).to be(:east)
      end
    end
  end
end