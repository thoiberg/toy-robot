##
# Simulates a robot, that is capable of moving forward and 
# pivoting
# @!attribute [r] x_position
#   @return [Integer] the current X axis position of the robot   
# @!attribute [r] y_position
#   @return [Integer] the current y position of the robot
# @!attribute [r] direction
#   @return [Symbol] the direction the robot is facing
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

  attr_reader :x_position, :y_position, :direction

  ##
  # Initialises the robot with it's starting position on the supplied
  # board
  # @param [Integer] x_position The X axis position that robot starts
  #   at
  # @param [Integer] y_position The y axis position that the robot
  #   starts at
  # @param [String] direction the direction the robot is facing
  def initialize(x_position, y_position, direction)
    @x_position = x_position
    @y_position = y_position
    @direction = direction.to_sym
  end

  ##
  # Returns data about it's current position and orientation
  # @return [Array] the current position and orientation
  def report_data
    [x_position, y_position, direction]
  end

  ##
  # Moves the robot forward in the direction it is facing. If no space counter
  # is given then the robot is moved forward one space.
  # @param [Integer] spaces the number of spaces the robot will move forward
  # @return [Void]
  def move(spaces)
    @x_position, @y_position = new_position(spaces)
  end

  ##
  # Turns the robot to the left of it's current position.
  # @return [Void]
  def left
      @direction = turn_clockwise(-1)
  end

  ##
  # Turns the robot to the right of it's current position.
  # @return [Void]
  def right
      @direction = turn_clockwise(1)
  end

  ##
  # returns the x and y coordinate modifiers for the current direction
  # @return [Integer, Integer] the x and y axis modifiers based on the 
  #   current direction the robot is facing
  def movement_modifiers
    self.class.const_get(@direction.upcase)
  end

  ##
  # returns the new x and y coordinates of the robot if it were to move
  # the given spaces in the x and y direction
  # @param [Integer] spaces_to_move The amount of spaces in the currently
  #   facing direction to move
  # @return [Array <Integer>] The new x and y coordinates
  def new_position(spaces_to_move)
    x_modifier, y_modifier = movement_modifiers
    new_x = @x_position + (spaces_to_move * x_modifier)
    new_y = @y_position + (spaces_to_move * y_modifier)

    return new_x, new_y
  end


  private

  ## 
  # Turns the robot clockwise the specified number of times
  # @param [Integer] turn_count the number of times to turn clockwise.
  #   To turn counter clockwise use a negative Integer
  # @return [Symbol] the new position the robot is facing. Will be one of 
  #   `CARDINAL_DIRECTIONS`
  def turn_clockwise(turn_count)
      # finds the position of the current direction and modifies it by the turn count 
      # to determine the new direction it's facing. Wraps around array as necessary
      new_orientation_index = (CARDINAL_DIRECTIONS.find_index(@direction) + turn_count) % CARDINAL_DIRECTIONS.length
      CARDINAL_DIRECTIONS[new_orientation_index]
  end
end