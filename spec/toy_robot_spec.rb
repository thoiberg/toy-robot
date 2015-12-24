require 'open3'

require_relative '../lib/robot'

describe 'functionality' do
    let(:script_path) { File.expand_path('../../toy_robot.rb', __FILE__)}
    let(:fixture_location) { File.expand_path('../fixtures', __FILE__) }

    describe 'user interface' do

        it 'accepts the file path of the command file as an argument' do
            output, status = execute_script("#{fixture_location}/report_only.rb")

            expect(status).to eq(0)
            expect(output).to eq("robot has not been placed in a valid location on the board\n")
        end
    end

    describe 'DSL' do
        it 'can move and report on the robots current location' do
            output, status = execute_script("#{fixture_location}/move_and_report")

            expect(status).to eq(0)
            expect(output).to eq("0,0,north\n0,1,north\n")
        end

        it 'can turn the robot and report the orientation' do
            output, status = execute_script("#{fixture_location}/turn_and_report")

            expect(status).to eq(0)
            expect(output).to eq("0,0,east\n0,0,south\n")
        end

        it 'prevents the robot from walking off the table, but still allows it to move around' do
            output, status = execute_script("#{fixture_location}/prevents_destruction")

            expect(status).to eq(0)
            expect(output).to eq("5,5,north\n3,5,west\n")
        end

        it 'can allow a custom board to be set' do
            output, status = execute_script("#{fixture_location}/custom_board")

            expect(status).to eq(0)
            expect(output).to eq("6,8,east\n8,8,east\n")
        end

        it 'does not move or turn the robot unless it has been placed' do
            output, status = execute_script("#{fixture_location}/unplaced_robot")

            expect(status).to eq(0)
            expect(output).to eq("robot has not been placed in a valid location on the board\n")
        end

        it 'can move the robot multiple steps at a time' do
            output, status = execute_script("#{fixture_location}/multiple_steps")

            expect(status).to eq(0)
            expect(output).to eq("2,3,east\n")
        end

        it 'reports on methods it cannot execute and continues with the next steps' do
            output, status = execute_script("#{fixture_location}/move_with_invalid_commands")

            expect(status).to eq(0)
            expect(output).to include("Robot does not know command: dance\n")
            expect(output).to include("3,2,east\n")
        end

    end
end



## Helper methods - will refactor these into a separate helper methods file if they need
# to be reused in multiple test files
def execute_script(commands_file_path)
    o, s = Open3.capture2("bundle exec ruby #{script_path} #{commands_file_path}")
    return o, s
end