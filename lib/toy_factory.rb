module ToyRobot
  class ToyFactory
    class << self

      def build_robot
        Toys::Robot.new
      end

    end
  end
end