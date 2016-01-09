#!/usr/bin/env ruby

require_relative 'lib/command_runner'
require_relative 'lib/board'

# TODO: add error handling for nonexistent file, empty file
commands = File.read(ARGV[0])

# Don't like this too much
board = Board.new(5,5)
command_runner = CommandRunner.new(board)