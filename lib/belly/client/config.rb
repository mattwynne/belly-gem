require 'belly/client/default_config'
module Belly
  class Config
    attr_reader :host, :port
    
    class << self
      def new(*args)
        return DefaultConfig.new unless File.exists?(path)
        super
      end
      
      def path
        File.expand_path('.belly')
      end
    end
    
    def initialize
      @default = DefaultConfig.new
      @host, @port = config_file['hub'].split(':')
    end
    
    def url
      "http://#{@host}:#{@port}"
    end
    
    def project
      config_file['project'] || @default.project
    end
    
    def user
      config_file['user'] || @default.user
    end
    
    private
    
    def config_file
      return @file if @file
      Belly.log("pwd is #{`pwd`}")
      Belly.log("Looking for config in #{Config.path}")
      @file = YAML.load_file(Config.path)
    end
  end
end
