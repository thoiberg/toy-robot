module ToyRobot
  class WriterFactory
    class << self

      def stdout_writer
        Writers::STDOUTWriter
      end

    end
  end
end