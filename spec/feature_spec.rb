require 'cli-test'

describe 'running the script', feature: true do
  include CliTest

  let(:script_path) { File.expand_path('../../toy-robot', __FILE__)}
  let(:fixture_location) { File.expand_path('../fixtures', __FILE__) }

  context 'when the script completes successfully' do

    let(:valid_commands_file) { "#{fixture_location}/valid_commands.yaml" }

    before do
      execute_script script_path, args: valid_commands_file, use_bundler: true
    end

    it 'returns a 0 status code' do
      expect(last_execution).to be_successful
    end

  end

  context 'when the commands key is not set in the config' do

    let(:no_commands_key_file) { "#{fixture_location}/missing_commands_key.yaml" }

    before do
      execute_script script_path, args: no_commands_key_file, use_bundler: true
    end

    it 'returns a failed status code' do
      expect(last_execution).not_to be_successful
    end

    it 'displays a message telling the user the file is invalid' do
      expect(last_execution.stderr).to include 'a list of commands must be supplied'
    end

  end

  context 'when report is called before place' do

    let(:report_before_place_file) { "#{fixture_location}/report_before_place.yaml" }

    before do
      execute_script script_path, args: report_before_place_file, use_bundler: true
    end

    it 'reports nothing' do
      expect(last_execution.stdout).to be_empty
    end

  end

  context 'when move is called before place' do

    let(:move_before_place_file) { "#{fixture_location}/move_before_place.yaml" }

    before do
      execute_script script_path, args: move_before_place_file, use_bundler: true
    end

    it 'is disregarded' do
      expect(last_execution.stdout).to include '0,0,north'
    end

  end

  context 'when left is called before place' do

    let(:left_before_place_file) { "#{fixture_location}/left_before_place.yaml" }

    before do
      execute_script script_path, args: left_before_place_file, use_bundler: true
    end

    it 'is disregarded' do
      expect(last_execution.stdout).to include '0,0,north'
    end

  end

  context 'when right is called before place' do

    let(:right_before_place_file) { "#{fixture_location}/right_before_place.yaml" }

    before do
      execute_script script_path, args: right_before_place_file, use_bundler: true
    end

    it 'is disregarded' do
      expect(last_execution.stdout).to include '0,0,north'
    end

  end

  context 'when robot is placed outside the board' do

    let(:placed_outside_the_board_file) { "#{fixture_location}/placed_outside_the_board.yaml" }

    before do
      execute_script script_path, args: placed_outside_the_board_file, use_bundler: true
    end

    it 'does not place the robot on the board' do
      expect(last_execution.stdout).to be_empty
    end

  end

  context 'when the robot tries to move off the board' do

    let(:moves_off_the_board_file) { "#{fixture_location}/moves_off_the_board_file.yaml" }

    before do
      execute_script script_path, args: moves_off_the_board_file, use_bundler: true
    end

    it 'ignores the move command' do
      expect(last_execution.stdout).to include '0,0,west'
    end

  end

end
