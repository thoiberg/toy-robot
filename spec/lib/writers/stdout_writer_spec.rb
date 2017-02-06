describe ToyRobot::Writers::STDOUTWriter do

  describe '::write' do

    let(:message) { Faker::Shakespeare.unique.hamlet_quote }
    let(:subject) { described_class.write message }

    before do
      allow(STDOUT).to receive :puts

      subject
    end

    it 'outputs the message to STDOUT' do
      expect(STDOUT).to have_received(:puts).with message
    end

  end

end