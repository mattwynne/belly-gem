require 'belly/client'

options = Trollop::options do
  banner <<-EOF
This is the help for the rerun command. To see all commands availlable, type belly --help

Usage: belly rerun

Show the Cucumber scenarios that need to be rerun

EOF
  opt :name, "Name of the project", :default => File.basename(Dir.pwd)
end

module Belly
  class Rerun
    def initialize(options)
    
    end
  
    def run(ui)
      scenarios = Belly.hub.get_failing_scenarios_for_project_named(Belly.config.project)
      todos = scenarios.map {  |scenario| "#{scenario["file_name"]}:#{scenario["line_number"]}" }
      todos.sort.each { |todo| puts todo }
    end
  end
end

Belly::Rerun.new(options).run(Trollop)