require File.dirname(__FILE__) + '/hub_client'

module Belly
  class Formatter
    class Config
      attr_reader :host, :port
      
      def initialize
        @host, @port = config_file['hub'].split(':')
      end
      
      private
      
      def config_file
        @file ||= YAML.load_file('.belly')
      end
    end
    
    def initialize(*args)
      config = Config.new
      @hub = Belly::HubClient.new(config.host, config.port)
    end
    
    def after_feature_element(scenario)
      @hub.add_scenario 'name' => scenario.name, 'status' => scenario.status
    end
  end
end
