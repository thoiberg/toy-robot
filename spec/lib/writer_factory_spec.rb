describe ToyRobot::WriterFactory do

  describe '::stdout_writer' do

    let(:subject) { described_class.stdout_writer }

    it 'returns the STDOUT writer' do
      expect(subject).to eq ToyRobot::Writers::STDOUTWriter
    end

  end

end