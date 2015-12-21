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

    describe '#can_move_to?' do
        it 'returns true if the new coordinates are valid' do
            expect(subject.can_move_to?(5,3)).to eq(true)
            expect(subject.can_move_to?(5,5)).to eq(true)
            expect(subject.can_move_to?(0,0)).to eq(true)
        end

        it 'returns false if the new coordinates are invalid' do
            expect(subject.can_move_to?(-1,3)).to eq(false)
            expect(subject.can_move_to?(1,-3)).to eq(false)
            expect(subject.can_move_to?(10,10)).to eq(false)
        end
    end
end