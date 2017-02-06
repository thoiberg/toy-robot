describe ToyRobot::ToyFactory do

  describe '::build_robot' do

    let(:subject) { described_class.build_robot }

    it 'returns a toy robot' do
      expect(subject).to be_instance_of ToyRobot::Toys::Robot
    end

  end

end