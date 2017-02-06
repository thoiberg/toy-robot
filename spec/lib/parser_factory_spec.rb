describe ToyRobot::ParserFactory do

  let(:subject) { described_class }

  describe '::yaml_parser' do

    it 'returns the YAML parser' do
      expect(subject.yaml_parser).to eq ToyRobot::Parsers::YAMLParser
    end

  end

end