# module with utility methods for formatting strings
module StringUtility
  extend self

  # takes the supplied string and returns it as a command
  # and array of arguments. Arguments are both space and
  # comma separated
  # @param [String] command_string The string to be processed
  # @return [Array<String, Array<String>>] The command and 
  # array of arguments to process
  def format_string_for_execution(command_string)
    command_parts = command_string.split(' ')
    cmd = command_parts.shift
    # joins all args by a , and then separates them again to sort
    # them by both space and comma
    
    args = command_parts.join(',').split(',')
    args.map! {|a| convert_to_num(a) }
    
    return cmd, args
  end

  # converts a number string to a Ruby object. If the string does
  # not match the regex expression then the original string is return
  # @param [String] string The string to be converted
  # @return [String, Integer, Float] The Ruby number or the original string,
  #   if the string cannot be converted
  def convert_to_num(string)
    return string.to_f if string =~ /\d+\.\d+/
    return string.to_i if string =~ /\d+/
    string
  end
end