##
# A class to simulate a Board with a set amount of spaces on it
# @attr_reader [Integer] x_places the amount of places the x axis should have
# @attr_reader [Integer] y_places the amount of places the y axis should have
class Board
    attr_reader :x_places, :y_places

    ##
    # Initializes an instance of a Board. Expects two arguments, detailing
    # the number of spaces on the x and y axes
    # @param x_places [Integer] the amount of spaces along the x axis the board
    #   should have
    # @param y_places [Integer] the amount of spaces along the y axis the board
    #   should have
    # @return [Board] an instance of the Board class
    def initialize(x_places, y_places)
        @x_places = x_places
        @y_places = y_places
    end
end