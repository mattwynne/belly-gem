module Belly
  module Messages
    class CucumberScenarioResultMessage
      def initialize(feature_name, scenario_name, status, user, project_name)
        @data = {
          :type => self.class.name,
          :id => {
            :feature => feature_name,
            :scenario => scenario_name
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