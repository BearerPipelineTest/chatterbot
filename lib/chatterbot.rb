require 'yaml'
require 'oauth'
require 'twitter'
require 'launchy'

#
# Try and load Sequel, but don't freak out if it's not there
begin
  require 'sequel'
rescue Exception
end


#
# extend Hash class to turn keys into symbols
#
class Hash
  #
  # turn keys in this hash into symbols
  def symbolize_keys!
    replace(inject({}) do |hash,(key,value)|
      hash[key.to_sym] = value.is_a?(Hash) ? value.symbolize_keys! : value
      hash
    end)
  end
end

#
# the big kahuna!
module Chatterbot
  #
  # load in our assorted modules
  def self.load
    require "chatterbot/config"
    require "chatterbot/db"
    require "chatterbot/logging"
    require "chatterbot/blacklist"
    require "chatterbot/ui"
    require "chatterbot/client"    
    require "chatterbot/search"
    require "chatterbot/tweet"
    require "chatterbot/retweet"
    require "chatterbot/reply"
    require "chatterbot/helpers"    

    require "chatterbot/bot"
  end

  require 'chatterbot/version'
  
  # Return a directory with the project libraries.
  def self.libdir
    t = [File.expand_path(File.dirname(__FILE__)), "#{Gem.dir}/gems/chatterbot-#{Chatterbot::VERSION}"]

    t.each {|i| return i if File.readable?(i) }
    raise "both paths are invalid: #{t}"
  end
end


# mount up
Chatterbot.load
