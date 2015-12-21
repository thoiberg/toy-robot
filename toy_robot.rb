#!/usr/bin/env ruby

require_relative 'lib/board'
require_relative 'lib/robot'

commands = File.read(ARGV[0])

robot = Robot.new

robot.execute_commands(commands)