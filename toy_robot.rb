#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/robot'
require_relative 'lib/command_parser'

commands = File.read(ARGV[0])

robot = Robot.new

#robot.execute_commands(commands)
CommandParser.relay_commands(commands, robot.get_binding)