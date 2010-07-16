require 'belly/project_initializer'

options = Trollop::options do
  banner <<-EOF
This is the help for the init command. To see all commands availlable, type belly --help

Usage: belly init <args>

Initialize your project for use with the belly web service

EOF
  opt :name, "Name of the project", :default => File.basename(Dir.pwd)
end

Belly::ProjectInitializer.new(options).run(Trollop)