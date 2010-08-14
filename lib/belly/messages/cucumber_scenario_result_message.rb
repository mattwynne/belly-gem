module Belly
  module Messages
    class CucumberScenarioResultMessage
      def initialize(feature_name, scenario_name, status, user, project_name, feature_file, line)
        @data = {
          :type => self.class.name,
          :id => {
            :feature => feature_name,
            :scenario => scenario_name,
            :feature_file => feature_file,
            :line => line
          },
          :status => status,
          :user => user,
          :project => project_name
        }
      end
      
      def to_json
        @data.to_json
      end
    end
  end
end