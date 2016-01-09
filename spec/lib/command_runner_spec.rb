require_relative '../../lib/command_runner'

describe CommandRunner do
    let (:robot) { Robot.new }
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
            cmds = {'move' => []}

            expect(command_runner.robot).to be_nil
            expect(command_runner.robot).to receive(:move).never

            command_runner.run_commands(cmds)
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

        it 'runs a command if the robot has been placed'
        it 'writes to STDOUT if the report command is executed'
    end
end