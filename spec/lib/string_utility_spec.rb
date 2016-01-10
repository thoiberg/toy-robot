require_relative '../../lib/string_utility'

describe StringUtility do
  describe '.format_string_for_execution' do
    it 'returns the string as a command and the arguments' do
      cmd, args = StringUtility.format_string_for_execution("place 0,1,north")

      expect(cmd).to eq('place')
      expect(args).to be_a_kind_of(Array)
      expect(args).to eq(['0','1','north'])
    end

    it 'returns an empty array for arguments if no args are passed in' do
      cmd, args = StringUtility.format_string_for_execution('move')

      expect(cmd).to eq('move')
      expect(args).to be_empty
    end
  end
end