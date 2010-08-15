module Belly
  class CucumberRerun
    def initialize(options)
    
    end
  
    def run(ui)
      Belly.hub.get_failing_scenarios_for_project_named(Belly.config.project).each do |scenario|
        puts "#{scenario["file_name"]}:#{scenario["line_number"]}"
      end
    end
  end
end