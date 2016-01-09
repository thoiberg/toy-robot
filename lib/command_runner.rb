require 'forwardable'

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
  extend Forwardable

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
      unless @robot.nil? and cmd != 'place'
        send("#{cmd.to_sym}_robot", *args)
      end
    end
  end

  private

  ##
  # Places the robot on the board. Makes sure the initial coordinates
  # are valid. If they are then the `@robot` variable is updated
  # @args [Integer] x_position The x_position to initialise the robot
  # @args [Integer] y_position The x_position to initialise the robot
  # @args [String] direction The direction the robot is facing
  # @return [Void]
  def place_robot(x_position, y_position, direction)
    if @board.can_be_placed_at? x_position, y_position
        @robot = Robot.new(x_position, y_position, direction)
    end
  end

  ##
  # Moves the robot. First checks to determine if the new position
  # exists on the board. If it does then the robot is moved, otherwise
  # it stays where it is
  # @param [Integer] x_position the new x axis position for the robot
  # @param [Integer] y_position the new y axis position for the robot 
  # @return [Void]
  def move_robot(spaces=1)
    if @board.can_move_to? *@robot.new_position(spaces)
        @robot.move spaces
    end
  end

  ##
  # Reports the current position and orientation of the robot
  # @return [Void]
  def report_robot
    puts "#{@robot.x_position},#{@robot.y_position},#{@robot.direction}"
  end

  def_delegators :@robot, :left, :right
  alias_method :left_robot, :left
  alias_method :right_robot, :right
end