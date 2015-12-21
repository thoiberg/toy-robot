require 'open3'

require_relative '../lib/robot'

describe 'functionality' do
    let(:script_path) { File.expand_path('../../toy_robot.rb', __FILE__)}
    let(:fixture_location) { File.expand_path('../fixtures', __FILE__) }

    describe 'user interface' do

        it 'accepts the file path of the command file as an argument' do
            output, status = execute_script("#{fixture_location}/report_only.rb")

            expect(status).to eq(0)
            expect(output).to eq(",,\n")
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
            expect(output).to eq("5,5,north\n3,5,east\n")
        end
    end
end



## Helper methods - will refactor these into a separate helper methods file if they need
# to be reused in multiple test files
def execute_script(commands_file_path)
    o, s = Open3.capture2("bundle exec ruby #{script_path} #{commands_file_path}")
    return o, s
end