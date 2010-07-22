$:.push(File.expand_path(File.dirname(__FILE__)))

require 'belly/client'
require 'belly/client/config'
require 'json'

module Belly
  class << self
    def log(message)
      return unless ENV['BELLY_DEBUG']
      puts "* [Belly] #{message}"
    end
  
    def publish(scenario)
      feature_name = scenario.feature.name.split("\n").first # TODO: only needed for older cucumbers
      data = { 
        :type => :cucumber_scenario_result,
        :id => { :feature => feature_name, :scenario => scenario.name }, 
        :status => scenario.status, 
        :project => config.project 
      }.to_json
      
      Belly.log("publishing #{data}")

      # Break out a thread so we don't slow down the tests
      thread = Thread.new { hub.post_test_result(data) }
      
      # Make sure the thread gets a chance to finish before the process exits
      at_exit { thread.join }
    end
  
    def config
      @config ||= Config.new
    end
    
    def hub
      @hub ||= Belly::Client.new(config)
    end
  end
end