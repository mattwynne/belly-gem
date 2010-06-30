module Belly
  class Config
    attr_reader :host, :port
    
    def initialize
      @host, @port = config_file['hub'].split(':')
    end
    
    def url
      "http://#{@host}:#{@port}"
    end
    
    private
    
    def config_file
      return @file if @file
      path = File.expand_path('.belly')
      Belly.log("pwd is #{`pwd`}")
      Belly.log("Looking for config in #{path}")
      @file = YAML.load_file(path)
    end
  end
end
