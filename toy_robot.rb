#!/usr/bin/env ruby

require_relative 'lib/command_runner'
require_relative 'lib/board'
require_relative 'lib/string_utility'

# TODO: add error handling for nonexistent file, empty file
command_text = File.read(ARGV[0])


board = Board.new(5,5)
command_runner = CommandRunner.new(board)

commands = command_text.split("\n")
commands.each do |command|
  # TODO: refactor into separate utility class
  unless command.empty?
    cmd, args = StringUtility.format_string_for_execution(command)

    command_runner.send(cmd.to_sym, *args)
  end
end
