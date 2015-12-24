##
# The CommandParser class is a utility class to eval commands against
# an execution context (Binding).
class CommandParser
    ##
    # Executes the commands from within the execution context
    # @param [String] commands the commands to be evaluated as Ruby code
    # @param [Binding] binding the execution context to evaluate the commands within
    def self.relay_commands(commands, binding)
        # There's a security concern with eval so I would never use it with code
        # from an untrusted source but since this will be run by the user locally
        # the security threat is low, since they would have more access to their own
        # systems outside of the code if they wanted to cause damage
        eval(commands, binding, __FILE__, __LINE__)
    end
end