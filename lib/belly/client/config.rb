module Belly
  class Config
    class NoConfig
    end
    
    attr_reader :host, :port
    
    class << self
      def new(*args)
        return NoConfig.new unless File.exists?(path)
        super
      end
      
      def path
        File.expand_path('.belly')
      end
    end
    
    def initialize
      @host, @port = config_file['hub'].split(':')
    end
    
    def url
      "http://#{@host}:#{@port}"
    end
    
    def project
      config_file['project']
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
