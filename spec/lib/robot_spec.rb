require_relative '../../lib/robot'
require_relative '../../lib/board'

describe Robot do 
    let(:subject) { Robot.new(0, 0, 'north', board) }
    let(:board) { Board.new(5,5) }

    describe '#initialize' do
        it 'requires the starting coordinates, direction and game board' do
            robot = Robot.new(0, 0, 'north', board)
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
        it 'moves the robot the amount of spaces in the direction it is facing' do
            subject.move(2)

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(2)

            subject = Robot.new(0, 0, 'east', board)
            subject.move(2)
            expect(subject.x_position).to eq(2)
            expect(subject.y_position).to eq(0)
        end

        it 'moves the robot forward one space if no count is supplied' do
            subject.move

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(1)
        end

        it 'moves no spaces if the count is 0' do
            subject.move(0)

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(0)
        end

        it 'moves in the opposite direction if a negative count is given' do
            robot = Robot.new(2, 5, :north, board)
            robot.move(-2)

            expect(robot.x_position).to eq(2)
            expect(robot.y_position).to eq(3)
            expect(robot.direction).to eq(:north)
        end

        it 'does not move if the robots new position is off of the board' do
            board = Board.new(5,5)
            robot = Robot.new(0, 0, :north, board)
            subject.move(board.y_places * 2) ## move twice the distance of the board's max y bound

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(0)
        end
    end

    describe '#left' do 
        it 'turns the robot to the left' do
            robot = Robot.new(0,0, :north, board)
            expect(robot.direction).to eq(:north)
            robot.left
            expect(robot.direction).to eq(:west) 

            robot = Robot.new(0,0, :south, board)
            expect(robot.direction).to eq(:south)
            robot.left
            expect(robot.direction).to eq(:east) 

            robot = Robot.new(0,0, :west, board)
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
            robot = Robot.new(0,0, :north, board)
            expect(robot.direction).to eq(:north)
            robot.right
            expect(robot.direction).to eq(:east) 

            robot = Robot.new(0,0, :west, board)
            expect(robot.direction).to eq(:west)
            robot.right
            expect(robot.direction).to eq(:north) 

            robot = Robot.new(0,0, :east, board)
            expect(robot.direction).to eq(:east)
            robot.right
            expect(robot.direction).to eq(:south)

            robot = Robot.new(0,0, :north, board)
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

end