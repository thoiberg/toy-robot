module ToyRobot
  module Writers
    class STDOUTWriter
      class << self

        def write message
          STDOUT.puts message
        end

      end
    end
  end
end