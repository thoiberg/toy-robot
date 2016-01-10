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
            expect(last_execution.stdout).to eq("")
        end
    end

    describe 'file processing' do
      it 'converts each line in the file into a separate hash entry' do
        execute_script(script_path, args: "#{fixture_location}/move_and_left", use_bundler: true)

        expect(last_execution).to be_successful
        expect(last_execution.stdout).to be_empty
      end

      it 'displays a message to the user when the file does not exist' do
        execute_script(script_path, args: 'i/dont/exist', use_bundler: true)

        expect(last_execution).not_to be_successful
        expect(last_execution.stdout).to eq("File: i/dont/exist could not be found\n")
      end

      it 'does not fail if the file is empty' do
        execute_script(script_path, args: "#{fixture_location}/empty_file", use_bundler: true)

        expect(last_execution).to be_successful
        expect(last_execution.stdout).to be_empty
      end
    end
    

    describe 'Robot game' do
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

        it 'does not move or turn the robot unless it has been placed' do
            execute_script(script_path, args: "#{fixture_location}/unplaced_robot", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("")
        end

        it 'can move the robot multiple steps at a time' do
            execute_script(script_path, args: "#{fixture_location}/multiple_steps", use_bundler: true)

            expect(last_execution).to be_successful
            expect(last_execution.stdout).to eq("2,3,east\n")
        end
    end
end