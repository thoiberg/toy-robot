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
    # Places the robot onto the board, at the given x and y positions
    # and facing in the given direction
    # @param [Integer] x_position the current X axis position of the robot
    # @param [Integer] y_position the current_y position of the robot
    # @param [Symbol] direction the direction the robot is facing
    # @param [Board] board the board the robot is on
    def place(x_position, y_position, direction, board=Board.new(5,5))
        if board.can_move_to?(x_position, y_position)
            @x_position = x_position
            @y_position = y_position
            @direction = direction
            @board = board
        end
    end

    ##
    # Reports the current position of the robot to STDOUT
    # @return [void]
    def report
        if placed?
            puts "#{x_position},#{y_position},#{direction}"
        else
            puts "robot has not been placed in a valid location on the board"
        end
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

    ##
    # Turns the robot to the left of it's current position. This is mainly a convience
    # method to assist with the DSL that gets executed in `execute_commands`
    # @return [void]
    def left
        turn(:left)
    end

    ##
    # Turns the robot to the right of it's current position. This is mainly a convience
    # method to assist with the DSL that gets executed in `execute_commands`
    # @return [void]
    def right
        turn(:right)
    end

    ##
    # Returns the current binding for the Robot object. This can be used to eval commands
    # against the obect
    # @return [Binding] current execution context
    def get_binding
        binding
    end


    private

    ## 
    # Turns the robot in an orientation
    # @param [Symbol] orientation the orientation the robot should be turned. Valid values are
    #    `:left` and `:right`
    # @return [void]
    def turn(orientation)
        if placed?
            if orientation == :left
                move_count = -1
            elsif orientation == :right
                move_count = 1
            end

            # finds the position of the current orientation and modifies it by 1 depending on the current
            # direction and then returns new position. Wraps around array as necessary
            new_orientation_index = (CARDINAL_DIRECTIONS.find_index(@direction) + move_count) % CARDINAL_DIRECTIONS.length
            @direction = CARDINAL_DIRECTIONS[new_orientation_index]
        end
    end
end