require_relative '../../lib/robot'
require_relative '../../lib/board'

describe Robot do 
  let(:subject) { Robot.new(0, 0, 'north') }
  let(:board) { Board.new(5,5) }

  describe '#initialize' do
    it 'requires the starting coordinates, direction and game board' do
      robot = Robot.new(0, 0, 'north')
      expect(robot).to be_a_kind_of(Robot)
    end
  end

  describe '#report' do
    it 'reports its current position and direction' do
      expect(STDOUT).to receive(:puts).with('0,0,north')
      subject.report
    end
  end

  describe '#move' do
    it 'the robot the amount of spaces in the direction it is facing' do
      subject.move(2)

      expect(subject.x_position).to eq(0)
      expect(subject.y_position).to eq(2)

      subject = Robot.new(0, 0, 'east')
      subject.move(2)
      expect(subject.x_position).to eq(2)
      expect(subject.y_position).to eq(0)
    end

    it 'no spaces if the count is 0' do
      subject.move(0)

      expect(subject.x_position).to eq(0)
      expect(subject.y_position).to eq(0)
    end

    it 'in the opposite direction if a negative count is given' do
      robot = Robot.new(2, 5, :north)
      robot.move(-2)

      expect(robot.x_position).to eq(2)
      expect(robot.y_position).to eq(3)
      expect(robot.direction).to eq(:north)
    end
  end

  describe '#new_position' do
    it 'returns the new position of the robot' do
      robot = Robot.new(0, 0, :north)
      new_x, new_y = robot.new_position(3)

      expect(new_x).to eq(0)
      expect(new_y).to eq(3)

      robot = Robot.new(3, 4, :south)
      new_x, new_y = robot.new_position(2)

      expect(new_x).to eq(3)
      expect(new_y).to eq(2)
    end

    it 'does not modify the current position' do
      robot = Robot.new(0, 0, :north)
      new_x, new_y = robot.new_position(3)

      expect(new_x).to eq(0)
      expect(new_y).to eq(3)
      expect(robot.x_position).to eq(0)
      expect(robot.y_position).to eq(0)
    end
  end

  describe '#left' do 
    it 'turns the robot to the left' do
      robot = Robot.new(0,0, :north)
      expect(robot.direction).to eq(:north)
      robot.left
      expect(robot.direction).to eq(:west) 

      robot = Robot.new(0,0, :south)
      expect(robot.direction).to eq(:south)
      robot.left
      expect(robot.direction).to eq(:east) 

      robot = Robot.new(0,0, :west)
      expect(robot.direction).to eq(:west)
      robot.left
      expect(robot.direction).to eq(:south) 
    end

    it 'does not change the position of the robot on the board' do
      subject.left

      expect(subject.direction).to eq(:west)
      expect(subject.x_position).to eq(0)
      expect(subject.y_position).to eq(0)
    end
  end

  describe '#right' do
    it 'turns the robot to the right' do
      robot = Robot.new(0,0, :north)
      expect(robot.direction).to eq(:north)
      robot.right
      expect(robot.direction).to eq(:east) 

      robot = Robot.new(0,0, :west)
      expect(robot.direction).to eq(:west)
      robot.right
      expect(robot.direction).to eq(:north) 

      robot = Robot.new(0,0, :east)
      expect(robot.direction).to eq(:east)
      robot.right
      expect(robot.direction).to eq(:south)

      robot = Robot.new(0,0, :north)
      expect(robot.direction).to eq(:north)
      robot.right
      robot.right
      expect(robot.direction).to eq(:south) 
    end

    it 'does not change the position of the robot on the board' do
      subject.right

      expect(subject.direction).to eq(:east)
      expect(subject.x_position).to eq(0)
      expect(subject.y_position).to eq(0)
    end
  end

  describe '#movement_modifiers' do
    it 'returns the x and y axis modifiers for the current direction' do
      robot = Robot.new(0,0, :north)
      expect(robot.movement_modifiers).to eq(Robot::NORTH)

      robot = Robot.new(0,0, :east)
      expect(robot.movement_modifiers).to eq(Robot::EAST)

      robot = Robot.new(0,0, :west)
      expect(robot.movement_modifiers).to eq(Robot::WEST)

      robot = Robot.new(0,0, :south)
      expect(robot.movement_modifiers).to eq(Robot::SOUTH)  
    end
  end
end