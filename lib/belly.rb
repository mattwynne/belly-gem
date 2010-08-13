$:.push(File.expand_path(File.dirname(__FILE__)))

require 'belly/client'
require 'belly/client/config'
require 'belly/messages/cucumber_scenario_result_message'
require 'json'

module Belly
  class << self
    def log(message)
      return unless ENV['BELLY_LOG']
      puts "* [Belly] #{message}"
    end
  
    def publish(scenario)
      return if offline?
      feature_name = scenario.feature.name.split("\n").first # TODO: only needed for older cucumbers

      data = Messages::CucumberScenarioResultMessage.new(
        feature_name, 
        scenario.name, 
        scenario.status,
        config.user,
        config.project).to_json
      
      Belly.log("publishing #{data}")

      # Break out a thread so we don't slow down the tests
      thread = Thread.new { hub.post_test_result(data) }
      
      # Make sure the thread gets a chance to finish before the process exits
      at_exit do
        begin
          thread.join
        rescue SocketError => exception
          # TODO: test this
          unless offline?
            warn("Belly couldn't send your results to the server. I suppose you're offline are you?")
            offline!
          end
        end
      end
    end
  
    def config
      @config ||= Config.new
    end
    
    def hub
      @hub ||= Belly::Client.new(config)
    end
    
  private
    
    def offline?
      @offline
    end
    
    def offline!
      @offline = true
    end
  end
end