require_relative 'board'
require_relative 'robot'

##
# The CommandRunner class is a class to run commands
# against the game elements
# @!attribute [r] board
#   @return [Board] the current board the game is being played on
# @!attribute [r]toy
#   @return [Robot] thetoy being moved around. Until atoy is
#     placed on the board thetoy is nil
class CommandRunner

  attr_reader :board, :toy

  ##
  # initialises the object.
  # @param [Board] board the game board to play on
  # @return [CommandRunner] the created instance
  def initialize(board, toy)
    @board = board
    @toy = toy

    unless @board.can_be_placed_at? @toy.x_position, @toy.y_position
      raise ArgumentError.new("#{@toy.class} cannot be placed")
    end
  end

  ##
  # Moves thetoy. First checks to determine if the new position
  # exists on the board. If it does then thetoy is moved, otherwise
  # it stays where it is
  # @param [Integer, String] spaces the amount of spaces to move thetoy forward
  # @return [Void]
  def move(spaces=1)
    spaces = spaces.to_i
    if @board.can_move_to? *@toy.new_position(spaces)
        @toy.move spaces
    end
  end

  ##
  # Reports the current position and orientation of thetoy
  # @return [Void]
  def report
    rd = @toy.report_data
    puts rd.join(',')
  end

  ##
  # Turns thetoy left
  # @return [Void]
  def left
    @toy.left
  end

  ##
  # Turns thetoy right
  # @return [Void]
  def right
    @toy.right
  end

end