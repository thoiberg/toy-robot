require 'open3'

require_relative '../lib/robot'


describe 'user interface' do
    let(:script_path) { File.expand_path('../../toy_robot.rb', __FILE__)}
    let(:fixture_location) { File.expand_path('../fixtures', __FILE__) }

    it 'accepts the file path of the command file as an argument' do
        output, status = execute_script("#{fixture_location}/report_only.rb")

        expect(status).to eq(0)
        expect(output).to include('')
    end
end



## Helper methods - will refactor these into a separate helper methods file if they need
# to be reused
def execute_script(commands_file_path)
    o, s = Open3.capture2("bundle exec ruby #{script_path} #{commands_file_path}")
    return o, s
end