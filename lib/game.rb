module ToyRobot
  class Game

    def initialize board, toy
      @board = board
      @toy = toy
    end

    def place_toy x_coordinate, y_coordinate, orientation
      if position_valid_on_board? x_coordinate, y_coordinate
        @toy.place x_coordinate, y_coordinate, orientation.to_sym
      end
    end

    def move_toy
      if toy_is_placed?
        new_x, new_y = @toy.new_position_if_moved

        if position_valid_on_board? new_x, new_y
          @toy.move
        end
      end
    end

    def report_toy_position writer
      if toy_is_placed?
        writer.write format_toy_report(@toy.report)
      end
    end

    def rotate_toy_left
      @toy.rotate_left if toy_is_placed?
    end

    def rotate_toy_right
      @toy.rotate_right if toy_is_placed?
    end

    private

    def position_valid_on_board? x_coordinate, y_coordinate
      @board.can_move_to? x_coordinate, y_coordinate
    end

    def toy_is_placed?
      @toy.placed?
    end

    def format_toy_report report
      "#{report[:x_coordinate]},#{report[:y_coordinate]},#{report[:orientation]}"
    end

  end
end