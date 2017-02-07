module ToyRobot
  module Toys
    class Toy

      include Movable

      def place x_coordinate, y_coordinate, orientation
        raise_not_implemented_error :place
      end

      def report
        raise_not_implemented_error :report
      end

      private

      def update_coordinates new_x, new_y
        raise_not_implemented_error :update_coordinates
      end

      def raise_not_implemented_error method_name
        raise NotImplementedError.new "#{method_name} must be implemented in subclass: #{self.class}"
      end

    end
  end
end