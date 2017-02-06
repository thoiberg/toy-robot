module ToyRobot

  class ToyRobotError < StandardError
  end

  class InvalidCommandsError < ToyRobotError
  end

  class InvalidCommandError < ToyRobotError
  end

end