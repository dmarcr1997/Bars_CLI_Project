require_relative "CLI_lib/version"
require_relative "CLI_lib/CLI"
require_relative "CLI_lib/API"
require_relative "CLI_lib/Events"
require 'pry'
require 'httparty'
require 'dotenv'
Dotenv.load

module EventCog

  def colorize(text, color_code) #text color functions
    "\e[#{color_code}m#{text}\e[0m"
  end
  
  def red(text) 
      colorize(text, 31)
  end
  # def green(text) 
  #     colorize(text, 32)
  # end
  def yellow(text)
    colorize(text,33)
  end

  def cyan(text)
    colorize(text, 36)
  end

  def white(text)
    colorize(text, 37)
  end

  # def add_color(text, color)
  #   '' +color(text) + ''
  # end

  class Error < StandardError; end
  
end
