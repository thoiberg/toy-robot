require_relative '../../lib/robot'

describe Robot do 
    let(:subject) { Robot.new }
    describe '#initialize' do
        it { is_expected.to be_a_kind_of(Robot) }
    end
end