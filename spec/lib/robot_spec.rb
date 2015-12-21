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
end