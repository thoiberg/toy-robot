#!/usr/bin/env ruby

require_relative 'lib/command_runner'
require_relative 'lib/board'
require_relative 'lib/string_utility'

begin
  command_text = File.read(ARGV[0])
rescue Errno::ENOENT
  puts "File: #{ARGV[0]} could not be found"
  exit(1)
end

command_runner = nil

commands = command_text.split("\n").reject(&:empty?)
commands.each do |command|
  begin
    cmd, args = StringUtility.format_string_for_execution(command)

    if cmd == 'place'
      board = Board.new(5,5)
      robot = Robot.new(*args)
      command_runner = CommandRunner.new(board, robot)
    else
      command_runner.send(cmd.to_sym, *args) if command_runner.respond_to? cmd.to_sym
    end
  rescue ArgumentError => ex
    # do nothing
  end
end
