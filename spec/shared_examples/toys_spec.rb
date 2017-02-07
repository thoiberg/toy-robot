shared_examples 'behaves like a toy' do

  let(:subject) { described_class.new }
  let(:x_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:y_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:orientation) { :north }

  describe '#report' do

    before do
      subject.place x_coordinate, y_coordinate, orientation
    end

    it 'reports its x coordinate' do
      expect(subject.report).to include({x_coordinate: x_coordinate})
    end

    it 'reports is y coordinate' do
      expect(subject.report).to include({y_coordinate: y_coordinate})
    end

    it 'reports its orientation' do
      expect(subject.report).to include({orientation: orientation})
    end

  end

  describe '#placed?' do

    context 'when the toy is placed' do

      before do
        subject.place x_coordinate, y_coordinate, orientation
      end

      it 'returns true' do
        expect(subject.placed?).to be true
      end

    end

    context 'when the toy is not placed' do

      it 'returns false' do
        expect(subject.placed?).to be false
      end

    end

  end

end