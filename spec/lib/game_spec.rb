describe ToyRobot::Game do

  let(:board) { double 'board' }
  let(:toy) { double 'toy' }
  let(:subject) { described_class.new board, toy }

  describe '#place_toy' do

    let(:x_coordinate) { Faker::Number.unique.number(3).to_i }
    let(:y_coordinate) { Faker::Number.unique.number(3).to_i }
    let(:orientation) { Faker::TwinPeaks.unique.character }

    before do
      allow(toy).to receive :place
      allow(board).to receive :valid_position?
    end

    it 'checks if the x coordinate is a valid position on the board' do
      subject.place_toy x_coordinate, y_coordinate, orientation

      expect(board).to have_received(:valid_position?).with x_coordinate, anything
    end

    it 'checks if the y coordinate is a valid position on the board' do
      subject.place_toy x_coordinate, y_coordinate, orientation

      expect(board).to have_received(:valid_position?).with anything, y_coordinate
    end

    context 'when the coordinates are a valid position on the board' do

      before do
        allow(board).to receive(:valid_position?).with(x_coordinate, y_coordinate).and_return true

        subject.place_toy x_coordinate, y_coordinate, orientation
      end

      it 'places the toy at the x coordinate' do
        expect(toy).to have_received(:place).with x_coordinate, anything, anything
      end

      it 'places the toy at the y coordinate' do
        expect(toy).to have_received(:place).with anything, y_coordinate, anything
      end

      it 'places the toy with the orientation' do
        expect(toy).to have_received(:place).with anything, anything, orientation
      end

    end

    context 'when the coordinates are not a valid position on the board' do

      before do
        allow(board).to receive(:valid_position?).with(x_coordinate, y_coordinate).and_return false

        subject.place_toy x_coordinate, y_coordinate, orientation
      end

      it 'does not place the toy' do
        expect(toy).not_to have_received :place
      end

    end

  end

  describe '#move_toy' do

    let(:new_x) { Faker::Number.unique.number(3).to_i }
    let(:new_y) { Faker::Number.unique.number(3).to_i }

    before do
      allow(toy).to receive(:new_position_if_moved).and_return [new_x, new_y]
      allow(toy).to receive :move
      allow(board).to receive(:valid_position?)
    end

    it 'checks what the new position would be' do
      subject.move_toy

      expect(toy).to have_received :new_position_if_moved
    end

    it 'checks that the new position is valid on the board' do
      subject.move_toy

      expect(board).to have_received(:valid_position?).with(new_x, new_y)
    end

    context 'when the new position is a valid position on the board' do

      before do
        allow(board).to receive(:valid_position?).with(new_x, new_y).and_return true

        subject.move_toy
      end

      it 'moves the toy' do
        expect(toy).to have_received :move
      end

    end

    context 'when the new position is not a valid position on the board' do

      before do
        allow(board).to receive(:valid_position?).with(new_x, new_y).and_return false

        subject.move_toy
      end

      it 'does not move the toy' do
        expect(toy).not_to have_received :move
      end

    end

  end

  describe '#report_toy_position' do

    before do
      allow(toy).to receive :report

      subject.report_toy_position
    end

    it 'reports the toys position and orientation' do
      expect(toy).to have_received :report
    end

  end

  describe '#rotate_toy_left' do

    before do
      allow(toy).to receive :rotate_left

      subject.rotate_toy_left
    end

    it 'rotates the toy to the left' do
      expect(toy).to have_received :rotate_left
    end

  end

  describe '#rotate_toy_right' do

    before do
      allow(toy).to receive :rotate_right

      subject.rotate_toy_right
    end

    it 'rotates the toy to the right' do
      expect(toy).to have_received :rotate_right
    end

  end


end