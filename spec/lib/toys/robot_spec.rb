describe ToyRobot::Toys::Robot do

  let(:x_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:y_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:orientation) { :north }
  let(:subject) { described_class.new }

  before do
    subject.place x_coordinate, y_coordinate, orientation
  end

  describe '#place' do

    it 'places the robot given coordinates and orientation' do
      expect(subject.report).to eq ({
        x_coordinate: x_coordinate,
        y_coordinate: y_coordinate,
        orientation: orientation
      })
    end

  end

  describe '#move' do

    before do
      subject.move
    end

    it 'moves the robot one place in the position its facing' do
      expect(subject.report[:y_coordinate]).to eq y_coordinate + 1
    end

  end

  describe '#new_position_if_moved' do

    before do
      subject.new_position_if_moved
    end

    it 'returns the new position of the robot' do
      expect(subject.new_position_if_moved).to eq [x_coordinate, y_coordinate + 1]
    end

    it 'does not move the robot' do
      expect(subject.report).to eq({
                                       x_coordinate: x_coordinate,
                                       y_coordinate: y_coordinate,
                                       orientation: orientation
                                   })
    end

  end

  describe '#report' do

    let(:report) { subject.report }

    it 'reports the current x coordinate' do
      expect(report[:x_coordinate]).to eq x_coordinate
    end

    it 'reports the current y coordinate' do
      expect(report[:y_coordinate]).to eq y_coordinate
    end

    it 'reports the current orientation' do
      expect(report[:orientation]).to eq orientation
    end

  end

  describe '#rotate_left' do

    [
        [:north, :west],
        [:west, :south],
        [:south, :east],
        [:east, :north]
    ].each do |current_orientation, expected_orientation|

      it "rotates the robot from #{current_orientation} to #{expected_orientation}" do
        subject.place x_coordinate, y_coordinate, current_orientation
        subject.rotate_left

        expect(subject.report[:orientation]).to eq expected_orientation
      end

    end

  end

  describe '#rotate_right' do

    [
        [:north, :east],
        [:east, :south],
        [:south, :west],
        [:west, :north]
    ].each do |current_orientation, expected_orientation|

      it "rotates the robot from #{current_orientation} to #{expected_orientation}" do
        subject.place x_coordinate, y_coordinate, current_orientation
        subject.rotate_right

        expect(subject.report[:orientation]).to eq expected_orientation
      end

    end

  end

end