describe ToyRobot::Parsers::YAMLParser do

  describe '::parse' do

    let(:commands_file_path) { Faker::StarWars.wookie_sentence }
    let(:subject) { described_class.parse commands_file_path }
    let(:command_list) { [Faker::StarWars.wookie_sentence] }
    let(:commands_class) { ToyRobot::Commands }
    let(:yaml_data) do
      {
          "commands" => command_list
      }
    end
    let(:commands) { instance_double commands_class }

    before do
      allow(YAML).to receive(:load_file).and_return yaml_data
      allow(commands_class).to receive(:new).and_return commands
    end

    it 'parses the file' do
      subject

      expect(YAML).to have_received(:load_file).with commands_file_path
    end

    context 'when the commands file is correctly configured' do

      before do
        subject
      end

      it 'creates a Commands object with the returned data' do
        expect(commands_class).to have_received(:new).with command_list
      end

      it 'returns the Commands object' do
        expect(subject).to eq commands
      end

    end

    context 'when the commands file is not correctly configured' do

      let(:yaml_data) { {Faker::StarWars.wookie_sentence => []} }

      it 'raises an error' do
        expect{subject}.to raise_error(ToyRobot::InvalidCommandsError)
      end

    end

  end

end