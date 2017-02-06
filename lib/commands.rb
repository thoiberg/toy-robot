require 'forwardable'

module ToyRobot
  class Commands
    extend Forwardable

    def_delegators :@commands, :each

    def initialize commands
      @commands = commands
    end

  end
end