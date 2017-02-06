require 'yaml'

module ToyRobot
  module Parsers
    class YAMLParser
      class << self

        def parse file_path
          yaml_data = YAML.load_file file_path

          validate! yaml_data

          Commands.new yaml_data['commands']
        end

        private

        def validate! yaml_data
          unless yaml_data['commands']
            raise ToyRobot::InvalidCommandsError.new 'a list of commands must be supplied'
          end
        end

      end
    end
  end
end