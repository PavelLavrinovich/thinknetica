require './menu_console'
require './help_console'

# Class for play with trains in console
class TrainConsole
  include MenuConsole
  include HelpConsole

  def start
    loop do
      help
      input = gets.chomp.to_sym
      break if input == :exit
      try_to_send(input)
    end
  end

  private

  def try_to_send(input)
    send(input)
  rescue NoMethodError
    unknown_command
  end
end
