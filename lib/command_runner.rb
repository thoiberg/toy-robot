require_relative 'board'
require_relative 'robot'

##
# The CommandRunner class is a class to run commands
# against the game elements
# @!attribute [r]
#   @return [Board] the current board the game is being played on
# @!attribute [r]
#   @return [Robot] the robot being moved around. Until a robot is
#     placed on the board the robot is `nil`
class CommandRunner
  attr_reader :board, :robot

  ##
  # initialises the object.
  # @param [Board] board the game board to play on
  # @return [CommandRunner] the created instance
  def initialize(board)
        @board = board
        @robot = nil
    end

  ##
  # @todo Refactor. I have a feeling this is going to become a code
  #   smell real soon.
  # Runs commands against the Robot on the board. Until the robot
  # is placed any other commands will be ignored
  # @param [Hash] cmds the commands passed in from the file. The key
  #   of the hash is the command to execute and the values is an array of
  #   arguments to pass to the command
  def run_commands(cmds)
    cmds.each do |cmd, args|
      if cmd == 'place'
        @robot = Robot.new(*args, @board)
      end

      unless @robot.nil?
        @robot.send(cmd.to_sym, *args)
      end
    end
  end

  private

  ##
  # Places the robot on the board. Makes sure the initial coordinates
  # are valid
  # @args [Array] args The arguments to pass into the Robot initialisation
  # @return [Robot] a object of type Robot
  def place_robot(*args)
    
  end

end