require_relative 'board'

##
# Simulates a robot, that is capable of moving forward and 
# pivoting
# @attr_reader [Integer] x_position the current X axis position 
#   of the robot
# @attr_reader [Integer] y_position the current_y position of
#   the robot
# @attr_reader [Symbol] direction the direction the robot is facing
# @attr_reader [Board] board the board the robot is on
class Robot
    ##
    # The x and y axis modifiers for a robot moving north. The modifiers
    # are multiplied by the number of steps to determine where the robot
    # should move to
    NORTH = 0,1
    ##
    # The x and y axis modifiers for a robot moving east.
    EAST = -1,0
    ##
    # The x and y axis modifiers for a robot moving south.
    SOUTH = 0,-1
    ##
    # The x and y axis modifiers for a robot moving west.
    WEST = 1,0

    attr_reader :x_position, :y_position, :direction, :board

    ##
    # Places the robot onto the board, at the given x and y positions
    # and facing in the given direction
    # @param [Integer] x_position the current X axis position of the robot
    # @param [Integer] y_position the current_y position of the robot
    # @param [Symbol] direction the direction the robot is facing
    # @param [Board] board the board the robot is on
    def place(x_position, y_position, direction, board=Board.new(5,5))
        @x_position = x_position
        @y_position = y_position
        @direction = direction
        @board = board
    end

    ##
    # Reports the current position of the robot to STDOUT
    def report
        puts "#{x_position},#{y_position},#{direction}"
    end

    ##
    # Takes a string of commands and instance_evals it to return to execute
    # commands against itself, to allow the robot to be moved
    # @param [String] commands a list of commands. Should follow ruby syntax
    # @return [void]
    def execute_commands(commands)
        instance_eval(commands)
    end

    ##
    # Moves the robot forward in the direction it is facing. If no space counter
    # is given then the robot is moved forward one space. If the robot has not
    # been placed yet the robot will not be moved. Addtionally, if the new position
    # of the robot is outside the board the robot will not be moved
    # @param [Integer] spaces the number of spaces the robot will move forward
    # @return [void]
    def move(spaces=1)
        if placed?
            movements = self.class.const_get(@direction.upcase)
            new_x, new_y = movements.map {|x| x * spaces}
            new_x += @x_position
            new_y += @y_position

            if @board.can_move_to?(new_x, new_y)
                @x_position = new_x
                @y_position = new_y
            end
        end
    end

    ##
    # Returns true if the `place` method has been run and the robot has been set on
    # a board. Returns false if otherwise
    # @return [Boolean] a value indicating whether the robot has been placed on a board
    def placed?
        !!(@x_position and @y_position) ? true : false
    end
end