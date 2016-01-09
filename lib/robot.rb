require_relative 'board'

##
# Simulates a robot, that is capable of moving forward and 
# pivoting
# @!attribute [r] x_position
#   @return [Integer] the current X axis position of the robot   
# @!attribute [r] y_position
#   @return [Integer] the current y position of the robot
# @!attribute [r] direction
#   @return [Symbol] the direction the robot is facing
# @!attribute [r] board
#   @return [Board] the board the robot is on
class Robot

  ##
  # An array of cardinal directions that the robot can move in.
  # Is listed in clockwise direction to allow robot to turn
  CARDINAL_DIRECTIONS = [:north, :east, :south, :west]
    
  ##
  # The x and y axis modifiers for a robot moving north. The modifiers
  # are multiplied by the number of steps to determine where the robot
  # should move to
  NORTH = 0,1
  ##
  # The x and y axis modifiers for a robot moving east.
  EAST = 1,0
  ##
  # The x and y axis modifiers for a robot moving south.
  SOUTH = 0,-1
  ##
  # The x and y axis modifiers for a robot moving west.
  WEST = -1,0

  attr_reader :x_position, :y_position, :direction, :board

  ##
  # Initialises the robot with it's starting position on the supplied
  # board
  # @param [Integer] x_position The X axis position that robot starts
  #   at
  # @param [Integer] y_position The y axis position that the robot
  #   starts at
  # @param [String] direction the direction the robot is facing
  # @param [Board] board the game board the robot is placed on
  def initialize(x_position, y_position, direction)
    @x_position = x_position
    @y_position = y_position
    @direction = direction.to_sym
  end

  ##
  # @todo move report method outside robot. Robot doesn't need to
  #   know how to format and display current position
  # Reports the current position of the robot to STDOUT
  # @return [Void]
  def report
   puts "#{x_position},#{y_position},#{direction}"
  end

  ##
  # Moves the robot forward in the direction it is facing. If no space counter
  # is given then the robot is moved forward one space. If the robot has not
  # been placed yet the robot will not be moved. Addtionally, if the new position
  # of the robot is outside the board the robot will not be moved
  # @param [Integer] spaces the number of spaces the robot will move forward
  # @oaram [Board] board The board the robot will move on
  # @return [Void]
  def move(spaces=1, board)
    movements = self.class.const_get(@direction.upcase)
      new_x, new_y = movements.map {|x| x * spaces}
      new_x += @x_position
      new_y += @y_position

      if board.can_move_to?(new_x, new_y)
          @x_position = new_x
          @y_position = new_y
      end
  end

  ##
  # Turns the robot to the left of it's current position. This is mainly a convience
  # method to assist with the DSL that gets executed in `execute_commands`
  # @return [Void]
  def left
      @direction = turn_clockwise(-1)
  end

  ##
  # Turns the robot to the right of it's current position. This is mainly a convience
  # method to assist with the DSL that gets executed in `execute_commands`
  # @return [Void]
  def right
      @direction = turn_clockwise(1)
  end

  private

  ## 
  # Turns the robot clockwise the specified number of times
  # @param [Integer] turn_count the number of times to turn clockwise in
  #   to turn counter clockwise use a negative Integer
  # @return [Symbol] the new position the robot is facing. Will be one of 
  #   `CARDINAL_DIRECTIONS`
  def turn_clockwise(turn_count)
      # finds the position of the current direction and modifies it by the turn count 
      # to determine the new direction it's facing. Wraps around array as necessary
      new_orientation_index = (CARDINAL_DIRECTIONS.find_index(@direction) + turn_count) % CARDINAL_DIRECTIONS.length
      CARDINAL_DIRECTIONS[new_orientation_index]
  end
end