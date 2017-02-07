module ToyRobot
  module Toys
    class Robot < Toy

      include CardinalDirectionsMovable

      def place x_coordinate, y_coordinate, orientation
        @x_coordinate = x_coordinate
        @y_coordinate = y_coordinate
        @orientation = orientation
      end

      private

      def x_coordinate
        @x_coordinate
      end

      def y_coordinate
        @y_coordinate
      end

      def orientation
        @orientation
      end

      def update_coordinates new_x, new_y
        @x_coordinate = new_x
        @y_coordinate = new_y
      end

      def update_orientation new_orientation
        @orientation = new_orientation
      end

    end
  end
end