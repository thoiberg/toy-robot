module ToyRobot
  class Game

    def initialize board, toy
      @board = board
      @toy = toy
    end

    def place_toy x_coordinate, y_coordinate, orientation
      if position_valid_on_board? x_coordinate, y_coordinate
        @toy.place x_coordinate, y_coordinate, orientation
      end
    end

    def move_toy
      new_x, new_y = @toy.new_position_if_moved

      if position_valid_on_board? new_x, new_y
        @toy.move
      end
    end

    def report_toy_position
      @toy.report
    end

    def rotate_toy_left
      @toy.rotate_left
    end

    def rotate_toy_right
      @toy.rotate_right
    end

    private

    def position_valid_on_board? x_coordinate, y_coordinate
      @board.valid_position? x_coordinate, y_coordinate
    end

  end
end