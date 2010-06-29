$:.push(File.expand_path(File.dirname(__FILE__)))

p "loaded belly"

begin
 Cucumber
rescue NameError
  raise LoadError, "You've tried to require the belly gem from somewhere that doesn't seem to be a Cucumber test suite. I'm afraid I can't handle that at the moment."
end

require 'belly/client'
require 'belly/client/config'
require 'json'

module Belly
  class << self
    def log(message)
      return unless ENV['BELLY_LOG']
      puts "* [Belly] #{message}"
    end
  
    def publish(scenario)
      feature_name = scenario.feature.name.split("\n").first # TODO: only needed for older cucumbers
      id = { :feature => feature_name, :scenario => scenario.name }
      
      data = { :id => id, :status => scenario.status }.to_json 
      Belly.log("publishing #{data}")
      hub.add_scenario(data)
    end
  
    def config
      @config ||= Config.new
    end
    
    def hub
      @hub ||= Belly::Client.new(config)
    end
  end
end

require 'belly/cucumber/hooks'