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

    ##
    # Method to tell if new coordinates are valid on the board. If coordinates
    # are within the board then the method returns true, otherwise, false
    # @param [Integer] new_x_position The proposed x axis value for a object
    #    to move to
    # @param [Integer] new_y_position The proposed y axis value for a object
    #    to move to
    # @return [Boolean] whether the proposed values are for a space that 
    #    exists on the board
    def can_move_to?(new_x_position, new_y_position)
        if (new_x_position <= x_places && new_x_position >= 0) && (new_y_position <= y_places && new_y_position >= 0)
            true
        else
            false
        end
    end
end