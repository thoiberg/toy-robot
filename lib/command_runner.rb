module ToyRobot
  class CommandRunner

    VALID_COMMANDS = %w[place move left right report]

    def initialize game, writer
      @game = game
      @writer = writer
    end

    def run command_string
      command, args = command_string.split(' ')

      validate_command! command

      if args
        send command.to_sym, args.split(',')
      else
        send command.to_sym
      end
    end

    private

    def move
      @game.move_toy
    end

    def report
      @game.report_toy_position @writer
    end

    def left
      @game.rotate_toy_left
    end

    def right
      @game.rotate_toy_right
    end

    def place arguments
      @game.place_toy *format_arguments_for_place(arguments)
    end

    def format_arguments_for_place args
      x_coordinate, y_coordinate, orientation = args
      return x_coordinate.to_i, y_coordinate.to_i, orientation
    end

    def validate_command! command
      unless VALID_COMMANDS.include? command
        raise InvalidCommandError.new("#{command} is not a valid command. Valid commands are: #{VALID_COMMANDS.join(' ')}")
      end
    end

  end
end