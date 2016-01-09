#!/usr/bin/env ruby

require_relative 'lib/command_runner'
require_relative 'lib/board'

# TODO: add error handling for nonexistent file, empty file
command_text = File.read(ARGV[0])

commands = command_text.split("\n")

command_hash = commands.inject({}) do |hash,command|
                 command_parts = command.split(' ')
                 hash[command_parts.shift] = command_parts

                 hash
               end

# Don't like this too much
board = Board.new(5,5)
command_runner = CommandRunner.new(board)

command_runner.run_commands(command_hash)

