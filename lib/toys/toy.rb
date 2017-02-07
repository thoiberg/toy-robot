module ToyRobot
  module Toys
    class Toy

      def place x_coordinate, y_coordinate, orientation
        raise_not_implemented_error :place
      end

      def move
        raise_not_implemented_error :move
      end

      def new_position_if_moved
        raise_not_implemented_error :new_position_if_moved
      end

      def report
        {
            x_coordinate: x_coordinate,
            y_coordinate: y_coordinate,
            orientation: orientation
        }
      end

      def rotate_left
        raise_not_implemented_error :rotate_left
      end

      def rotate_right
        raise_not_implemented_error :rotate_right
      end

      private

      def x_coordinate
        raise_not_implemented_error :x_coordinate
      end

      def y_coordinate
        raise_not_implemented_error :y_coordinate
      end

      def orientation
        raise_not_implemented_error :orientation
      end

      def update_coordinates new_x, new_y
        raise_not_implemented_error :update_coordinates
      end

      def update_orientation new_orientation
        raise_not_implemented_error :orientation
      end

      def raise_not_implemented_error method_name
        raise NotImplementedError.new "#{method_name} must be implemented in subclass: #{self.class}"
      end

    end
  end
end