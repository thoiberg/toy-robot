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
    def execute_commands(commands)
        instance_eval(commands)
    end
end