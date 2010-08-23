options = Trollop::options do
  banner <<-EOF
This is the help for the init command. To see all commands availlable, type belly --help

Usage: belly init

Initialize your project for use with the belly service

EOF
  opt :force, 'Overwite files even if they already exist', :default => false
end

require 'belly/client/default_config'
module Belly
  class Init
    
    def initialize(options)
      @options = options
    end
    
    def run(ui)
      unless File.exists?('features/support')
        ui.die("It doesn't look like you are in a project with Cucumber features")
      end

      create_file('features/support/belly.rb') do
        <<-EOF
require 'belly/for/cucumber'
EOF
      end
      
      create_file('.belly') do
        <<-EOF
hub: #{default_config.host}:#{default_config.port}
project: #{default_config.project}
user:
  name: #{default_config.user[:name]}
  email: #{default_config.user[:email]}
EOF
      end
    
      puts
      puts "Lovely. Your project is now initialized for use with Belly."
      puts "You can edit your project's settings by editing the .belly file in this folder."
    end
  
    private
    
    def default_config
      @default_config ||= Belly::Client::DefaultConfig.new
    end
  
    def create_file(target)
      FileUtils.rm_rf(target) if @options[:force]
      if File.exists?(target)
        Trollop.die("#{target} already exists. Use --force to make me overwrite it")
      end
      File.open(target, 'w') do |f|
        f.puts yield
      end
      puts "Created #{target}"
    end
  end
end

Belly::Init.new(options).run(Trollop)