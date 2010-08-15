module Belly
  module Client
    def publish(scenario)
      return if offline?
      
      feature_name = scenario.feature.name.split("\n").first # TODO: only needed for older cucumbers
      feature_file, line = scenario.file_colon_line.split(':')

      data = Messages::CucumberScenarioResultMessage.new(
        feature_name, 
        scenario.name, 
        scenario.status,
        config.user,
        config.project,
        feature_file,
        line).to_json

      Belly.log("publishing #{data}")

      # Break out a thread so we don't slow down the tests
      thread = Thread.new { hub.post_test_result(data) }

      # Make sure the thread gets a chance to finish before the process exits
      at_exit do
        begin
          thread.join
        rescue SocketError, Errno::ECONNREFUSED => exception
          # TODO: test this
          unless offline?
            warn("Belly couldn't send your results to the server (#{Belly.config.url}).")
            offline!
          end
        end
      end
    end

    def config
      @config ||= Config.new
    end

    def hub
      @hub ||= HubProxy.new(config)
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

Belly.extend(Belly::Client)

require 'json'
require 'belly/client/hub_proxy'
require 'belly/client/config'
require 'belly/messages/cucumber_scenario_result_message'
require 'belly/client/fakeweb_hack'