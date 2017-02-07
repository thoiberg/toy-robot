describe ToyRobot::CommandRunner do

  let(:game) { instance_double ToyRobot::Game }
  let(:writer) { class_double ToyRobot::Writers::STDOUTWriter }
  let(:subject) { described_class.new game, writer }

  describe '#run' do

    let(:toy_position) { Faker::GameOfThrones.house }

    before do
      allow(game).to receive :place_toy
      allow(game).to receive :move_toy
      allow(game).to receive(:report_toy_position).and_return toy_position
      allow(game).to receive :rotate_toy_left
      allow(game).to receive :rotate_toy_right

      allow(writer).to receive :write
    end

    context 'when the command is valid' do

      before do
        subject.run command
      end

      context 'and the command is move' do

        let(:command) { 'move' }

        it 'tells the game to move the toy' do
          expect(game).to have_received :move_toy
        end

      end

      context 'and the command is report' do

        let(:command) { 'report' }

        it 'passes the writer to the game to report the toy position' do
          expect(game).to have_received(:report_toy_position).with writer
        end

      end

      context 'and the command is left' do

        let(:command) { 'left' }

        it 'tells the game to rotate the toy to the left' do
          expect(game).to have_received :rotate_toy_left
        end

      end

      context 'and the command is right' do

        let(:command) { 'right' }

        it 'tells the game to rotate the toy to the right' do
          expect(game).to have_received :rotate_toy_right
        end

      end

      context 'and the command is place' do

        let(:x_coordinate) { Faker::Number.unique.digit.to_i }
        let(:y_coordinate) { Faker::Number.unique.digit.to_i }
        let(:orientation) { Faker::Crypto.md5 }
        let(:command) { "place #{x_coordinate},#{y_coordinate},#{orientation}" }

        it 'tells the game to place the toy with the x coordinate' do
          expect(game).to have_received(:place_toy).with x_coordinate, anything, anything
          end

        it 'tells the game to place the toy with the y coordinate' do
          expect(game).to have_received(:place_toy).with anything, y_coordinate, anything
        end

        it 'tells the game to place the toy with the orientation' do
          expect(game).to have_received(:place_toy).with anything, anything, orientation
        end

      end

    end

    context 'when command is not valid' do

      let(:command) { Faker::GameOfThrones.character }

      it 'raises an exception' do
        expect{ subject.run command }.to raise_error ToyRobot::InvalidCommandError

      end

    end

  end

end