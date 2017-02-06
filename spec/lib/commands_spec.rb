describe ToyRobot::Commands do

  let(:command) { Faker::TwinPeaks.quote.upcase }
  let(:command_strings) { [command] }
  let(:subject) { described_class.new command_strings }

  describe '#each' do

    let(:commands) do
      commands = []
      subject.each {|command| commands << command}

      commands
    end

    it 'downcases all commands' do
      expect(commands.first).to eq command.downcase
    end

  end

end