describe ToyRobot::Toys::Robot do

  let(:x_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:y_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:orientation) { :north }
  let(:subject) { described_class.new }

  include_examples 'behaves like a toy'
  include_examples 'can move and rotate on the cardinal directions'

  describe '#place' do

    context 'when orientation is valid' do

      before do
        subject.place x_coordinate, y_coordinate, orientation
      end

      it 'places the robot given coordinates and orientation' do
        expect(subject.report).to eq ({
            x_coordinate: x_coordinate,
            y_coordinate: y_coordinate,
            orientation: orientation
        })
      end

    end

    context 'when orientation is not valid' do

      let(:orientation) { Faker::StarWars.wookie_sentence }

      it 'raises an error' do
        expect{ subject.place x_coordinate, y_coordinate, orientation }.to raise_error ToyRobot::InvalidOrientationError
      end

    end

  end

end