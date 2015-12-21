#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/robot'

command_file = ARGV[0]

commands = File.read(command_file)

robot = Robot.new
board = Board.new(5,5)
commands.split("\n").each do |command|

end