require_relative "CLI_lib/version"
require_relative "CLI_lib/CLI"
require_relative "CLI_lib/API"
require_relative "CLI_lib/Events"

require 'pry'
require 'nokogiri'
require 'open-uri'
require 'httparty'

module EventCog
  class Error < StandardError; end
  # Your code goes here...
end
