require_relative '../toy_robot'
require_relative '../lib/robot'


describe 'user integration' do
    let(:script_location) { File.expand_path('../../toy_robot.rb', __FILE__)}
    let(:execute_script) { `bundle exec ruby #{script_location} 0 0 north` }

    it 'can accept the robot starting position and direction as script arguments' do
        x,y,direction = [0,0,:north]
        robot = instance_double('Robot')
        expect(Robot).to receive(:new).and_return(robot)
        expect(robot).to receive(:place).with(x, y, direction, kind_of(Board))

        execute_script
    end
end