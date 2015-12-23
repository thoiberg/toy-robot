##
# The CommandParser class is a utility class to eval commands against
# an execution context (Binding).
class CommandParser
    ##
    # Executes the commands from within the execution context
    # @param [String] commands the commands to be evaluated as Ruby code
    # @param [Binding] binding the execution context to evaluate the commands within
    def self.relay_commands(commands, binding)
        eval(commands, binding)
    end
end