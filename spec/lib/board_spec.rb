describe ToyRobot::Board do

  let(:x_length) { Faker::Number.positive(2).to_i }
  let(:y_length) { Faker::Number.positive(2).to_i }
  let(:subject) { described_class.new x_length, y_length }

  describe '#can_move_to?' do

    let(:x_coordinate) { x_length - 1 }
    let(:y_coordinate) { y_length - 1 }
    let(:can_move_to?) { subject.can_move_to? x_coordinate, y_coordinate }

    context 'when both coordinates are valid' do

      it 'returns true' do
        expect(can_move_to?).to be true
      end

    end

    context 'when x coordinate is 0' do

      let(:x_coordinate) { 0 }

      it 'returns true' do
        expect(can_move_to?).to be true
      end

    end

    context 'when y coordinate is 0' do

      let(:y_coordinate) { 0 }

      it 'returns true' do
        expect(can_move_to?).to be true
      end

    end

    context 'when the x coordinate is below zero' do

      let(:x_coordinate) { -1 }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    context 'when the x coordinate is the same number as the board length' do

      let(:x_coordinate) { x_length }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    context 'when the x coordinate is above the length of the board' do

      let(:x_coordinate) { x_length + 1 }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    context 'when the y coordinate is below zero' do

      let(:y_coordinate) { -1 }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    context 'when the y coordinate is the same number as the board length' do

      let(:y_coordinate) { y_length }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    context 'when the y coordinate is above the length of the board' do

      let(:y_coordinate) { y_length + 1 }

      it 'returns false' do
        expect(can_move_to?).to be false
      end

    end

    # context 'when position is less than zero' do
    #
    #   let(:x_coordinate) { -1 }
    #   let(:y_coordinate) { y_length - 1 }
    #
    #   it 'returns false' do
    #     expect(can_move_to?).to eq false
    #   end
    #
    # end

  end

end