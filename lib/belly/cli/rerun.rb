require 'belly/rerun'

options = Trollop::options do
  banner <<-EOF
This is the help for the rerun command. To see all commands availlable, type belly --help

Usage: belly rerun

Show the Cucumber scenarios that need to be rerun

EOF
  opt :name, "Name of the project", :default => File.basename(Dir.pwd)
end

Belly::Rerun.new(options).run(Trollop)