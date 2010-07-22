require 'belly/cucumber_rerun'

options = Trollop::options do
  banner <<-EOF
This is the help for the rerun:cucumber command. To see all commands availlable, type belly --help

Usage: belly rerun:cucumber

Show the Cucumber scenarios that need to be rerun

EOF
  opt :name, "Name of the project", :default => File.basename(Dir.pwd)
end

Belly::CucumberRerun.new(options).run(Trollop)