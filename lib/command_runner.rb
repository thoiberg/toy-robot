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
  # @param [Symbol] method the command passed in for the UI.
  # @param [Array<String>] args Any arguments passed in from the command
  # @paramn [Block] blk An optional block passed in
  def method_missing(method_name, *args, &blk)
    
    unless @robot.nil? and method_name != :place
      method = "#{method_name}_robot"
      send(method, *args) if respond_to?(method.to_sym, true)
      end
  end

  def respond_to_missing?(method_name, include_private = false)
    method = "#{method_name}_robot".to_sym
    (methods.include? method or private_methods.include? method) || super
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
    x_position = x_position.to_i
    y_position = y_position.to_i
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
    spaces = spaces.to_i
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

  ##
  # Turns the robot left
  # @return [Void]
  def left_robot
    @robot.left
  end

  ##
  # Turns the robot right
  # @return [Void]
  def right_robot
    @robot.right
  end

end