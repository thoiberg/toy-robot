require_relative '../../lib/command_parser'
require_relative '../../lib/robot'

describe CommandParser do
    let (:robot) { Robot.new }
    let (:commands) { %Q{place(0, 0, :north)} }

    describe '.relay_commands' do
        it 'evaluates the commands with the supplied binding' do
            expect(robot).not_to be_placed

            CommandParser.relay_commands(commands, robot.get_binding)

            expect(robot).to be_placed
            expect(robot.direction).to eq(:north)
            expect(robot.x_position).to eq(0)
            expect(robot.y_position).to eq(0)
        end
    end
end