#!/usr/bin/env ruby

require_relative 'lib/command_runner'
require_relative 'lib/board'

# TODO: add error handling for nonexistent file, empty file
command_text = File.read(ARGV[0])


board = Board.new(5,5)
command_runner = CommandRunner.new(board)

commands = command_text.split("\n")
commands.each do |command|
  # TODO: refactor into separate utility class
  unless command.empty?
    command_parts = command.split(' ')
    cmd = command_parts.shift
    args = command_parts.join(',').split(',')

    command_runner.run_command(cmd => args)
  end
end
