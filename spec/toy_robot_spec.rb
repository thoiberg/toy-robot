require 'open3'
require 'cli-test'

require_relative '../lib/robot'

describe 'functionality' do
    include CliTest

    let(:script_path) { File.expand_path('../../toy_robot.rb', __FILE__)}
    let(:fixture_location) { File.expand_path('../fixtures', __FILE__) }

    describe 'user interface' do
        it 'accepts the file path of the command file as an argument' do
            execute_script(script_path, args: "#{fixture_location}/report_only.rb", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("robot has not been placed in a valid location on the board\n")
        end
    end

    describe 'DSL' do
        it 'can move and report on the robots current location' do
            execute_script(script_path, args: "#{fixture_location}/move_and_report", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("0,0,north\n0,1,north\n")
        end

        it 'can turn the robot and report the orientation' do
            execute_script(script_path, args: "#{fixture_location}/turn_and_report", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("0,0,east\n0,0,south\n")
        end

        it 'prevents the robot from walking off the table, but still allows it to move around' do
            execute_script(script_path, args: "#{fixture_location}/prevents_destruction", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("5,5,north\n3,5,west\n")
        end

        it 'can allow a custom board to be set' do
            execute_script(script_path, args: "#{fixture_location}/custom_board", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("6,8,east\n8,8,east\n")
        end

        it 'does not move or turn the robot unless it has been placed' do
            execute_script(script_path, args: "#{fixture_location}/unplaced_robot", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("robot has not been placed in a valid location on the board\n")
        end

        it 'can move the robot multiple steps at a time' do
            execute_script(script_path, args: "#{fixture_location}/multiple_steps", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("2,3,east\n")
        end

        it 'reports on methods it cannot execute and continues with the next steps' do
            execute_script(script_path, args: "#{fixture_location}/move_with_invalid_commands", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to include("Robot does not know command: dance\n")
            expect(last_execution.stdout).to include("3,2,east\n")
        end

    end
end