module ToyRobot
  class ParserFactory
    class << self

      def yaml_parser
        Parsers::YAMLParser
      end

    end
  end
end