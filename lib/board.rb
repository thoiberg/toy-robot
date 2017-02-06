module ToyRobot
  class Board

    def initialize x_length, y_length
      @x_length = x_length
      @y_length = y_length
    end

    def can_move_to? x_coordinate, y_coordinate
      is_x_coordinate_valid?(x_coordinate) && is_y_coordinate_valid?(y_coordinate)
    end

    private

    def is_x_coordinate_valid? x_coordinate
      x_coordinate <= x_limit && x_coordinate >= 0
    end

    def x_limit
      @x_length - 1
    end

    def is_y_coordinate_valid? y_coordinate
      y_coordinate <= y_limit && y_coordinate >= 0
    end

    def y_limit
      @y_length - 1
    end




  end
end