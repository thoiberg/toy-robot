module ToyRobot
  module Toys
    class Robot < Toy

      include CardinalDirectionsMovable

      def place x_coordinate, y_coordinate, orientation
        @x_coordinate = x_coordinate
        @y_coordinate = y_coordinate
        @orientation = orientation

        validate!
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

      def validate!
        if not orientation_is_valid?
          raise InvalidOrientationError.new "#{orientation} is not valid. possible orientations are: #{possible_orientations}"
        end
      end

      def orientation_is_valid?
        possible_orientations.include? orientation
      end

    end
  end
end