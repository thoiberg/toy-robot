module ToyRobot
  module Movable

    def move spaces=1
      new_x, new_y = new_position spaces

      update_coordinates new_x, new_y
    end

    def new_position_if_moved spaces=1
      new_position spaces
    end

    def rotate_left
      new_orientation = turn_counter_clockwise 1

      update_orientation new_orientation
    end

    def rotate_right
      new_orientation = turn_clockwise 1

      update_orientation new_orientation
    end

    private

    def new_position spaces_to_move
      x_modifier, y_modifier = movement_modifiers
      new_x = x_coordinate + (spaces_to_move * x_modifier)
      new_y = y_coordinate + (spaces_to_move * y_modifier)

      return new_x, new_y
    end

    def movement_modifiers
      orientation_movement_modifiers[orientation]
    end

    def turn_counter_clockwise turn_count
      turn_clockwise turn_count * -1
    end

    def turn_clockwise turn_count
      new_orientation_index = (possible_orientations.find_index(orientation) + turn_count) % possible_orientations.length

      possible_orientations[new_orientation_index]
    end

    def orientation_movement_modifiers
      raise NotImplementedError.new "#{orientation_movement_modifiers} must be implemented to use the Movable mixin"
    end

    def possible_orientations
      raise NotImplementedError.new "#{orientation_movement_modifiers} must be implemented to use the Movable mixin"
    end

  end
end