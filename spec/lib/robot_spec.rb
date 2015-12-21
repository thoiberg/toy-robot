require_relative '../../lib/robot'
require_relative '../../lib/board'

describe Robot do 
    let(:subject) { Robot.new }
    let(:board) { Board.new(5,5) }
    describe '#initialize' do
        it { is_expected.to be_a_kind_of(Robot) }
    end

    describe '#place' do
        it 'accepts a x and y position, a direction to face and a board to be placed on' do
            subject.place(0,3,:north, board)

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(3)
            expect(subject.direction).to eq(:north)
            expect(subject.board).to eq(board)
        end

        it 'creates a default Board object if one is not supplied' do 
            subject.place(0,4,:east)

            expect(subject.board).to be_a_kind_of(Board)
            expect(subject.board.x_places).to eq(5)
            expect(subject.board.y_places).to eq(5)
        end

        it 'does not place the robot if the position is out of bounds on the board'
    end

    describe '#report' do
        it 'reports its current position and direction' do
            subject.place(0,0,:north, board)

            expect(STDOUT).to receive(:puts).with('0,0,north')
            subject.report
        end
    end

    describe '#execute_commands' do
        it 'executes a block of commands against itself' do
            commands = %Q{ place(0,0,:north)
                           report
                        }

            expect(STDOUT).to receive(:puts).with('0,0,north')

            subject.execute_commands(commands)
        end
    end

    describe '#move' do
        it 'moves the robot the amount of spaces in the direction it is facing' do
            subject.place(0, 0, :north)
            subject.move(2)

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(2)

            subject.place(0, 0, :west)
            subject.move(2)

            expect(subject.x_position).to eq(2)
            expect(subject.y_position).to eq(0)
        end

        it 'moves the robot forward one space if no count is supplied' do
            subject.place(0, 0, :north)
            subject.move

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(1)
        end

        it 'moves no spaces if the count is 0' do
            subject.place(2, 2, :south)
            subject.move(0)

            expect(subject.x_position).to eq(2)
            expect(subject.y_position).to eq(2)
        end

        it 'moves in the opposite direction if a negative count is given' do
            subject.place(2, 5, :north)
            subject.move(-2)

            expect(subject.x_position).to eq(2)
            expect(subject.y_position).to eq(3)
            expect(subject.direction).to eq(:north)
        end

        it 'does nothing if the robot has not been placed yet' do
            expect(subject.placed?).to be_falsey
            subject.move

            expect(subject.x_position).to be_nil
            expect(subject.y_position).to be_nil
            expect(subject.placed?).to be_falsey
        end

        it 'does not move if the robots new position is off of the board' do
            board = Board.new(5,5)
            subject.place(0, 0, :north, board)
            subject.move(board.y_places * 2) ## move twice the distance of the board's max y bound

            expect(subject.x_position).to eq(0)
            expect(subject.y_position).to eq(0)
        end
    end

    describe '#placed?' do
        it 'returns true if the robot is placed' do
            subject.place(0, 0, :north)
            expect(subject.placed?).to eq(true)
        end

        it 'returns false if the robot is not placed' do
            expect(subject.x_position).to be_nil
            expect(subject.y_position).to be_nil

            expect(subject.placed?).to eq(false)
        end
    end
end