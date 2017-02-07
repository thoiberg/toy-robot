shared_examples 'can move and rotate on the cardinal directions' do

  let(:subject) { described_class.new }
  let(:x_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:y_coordinate) { Faker::Number.unique.number(2).to_i }
  let(:orientation) { :north }

  describe '#new_position_if_moved' do

    before do
      subject.place x_coordinate, y_coordinate, orientation
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

  describe '#move' do

    before do
      subject.place x_coordinate, y_coordinate, orientation
      subject.move
    end

    it 'moves the robot one place in the position its facing' do
      expect(subject.report[:y_coordinate]).to eq y_coordinate + 1
    end

  end

  describe '#rotate_left' do

    before do
      subject.place x_coordinate, y_coordinate, orientation
    end

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

    before do
      subject.place x_coordinate, y_coordinate, orientation
    end

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