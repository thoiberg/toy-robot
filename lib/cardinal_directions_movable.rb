module ToyRobot
  module CardinalDirectionsMovable
    include Movable

    def orientation_movement_modifiers
      {
          north: [0, 1],
          east: [1, 0],
          south: [0, -1],
          west: [-1, 0]
      }
    end

    def possible_orientations
      %i{ north east south west }
    end

  end
end