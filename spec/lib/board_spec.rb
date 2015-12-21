require_relative '../../lib/board'

describe Board do
    let(:subject) { Board.new(5,5) }
    describe '#initialize' do
        it {is_expected.to be_a_kind_of(Board) }

        it 'accepts the amount of x and y spaces as arguments' do
            board = Board.new(4,7)
            expect(board.x_places).to eq(4)
            expect(board.y_places).to eq(7)
        end
    end
end