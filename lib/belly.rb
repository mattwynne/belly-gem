$:.push(File.expand_path(File.dirname(__FILE__)))

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
      
      data = { :id => id, :status => scenario.status, :project => config.project }.to_json
      Belly.log("publishing #{data}")
      hub.post_test_result(data)
    end
  
    def config
      @config ||= Config.new
    end
    
    def user_credentials
      @user_credentials ||= UserCredentials.new(config)
    end
    
    def hub
      @hub ||= Belly::Client.new(config)
    end
  end
end