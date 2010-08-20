module Belly
  module Messages
    class CucumberScenarioResultMessage
      def initialize(feature_name, scenario, user, project_name, feature_file, line)
        @data = {
          :type => self.class.name,
          :id => {
            :feature => feature_name,
            :scenario => scenario.name,
            :feature_file => feature_file,
            :line => line
          },
          :exception => {
            :message => scenario.exception.to_s
          },
          :status => scenario.status,
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