require 'net/http'
require 'uri'

module Belly
  class Client
    def initialize(config)
      @config = config
    end
    
    def get(uri)
      
    end
    
    def post_test_result(data)
      request = Net::HTTP::Post.new(@config.url + '/test_results', {'Content-Type' =>'application/json'})
      request.body = data
      response = Net::HTTP.new(@config.host, @config.port).start {|http| http.request(request) }
      unless response.code == "200"
        raise("Failed to talk to belly hub: Response #{response.code} #{response.message}: #{response.body}") 
      end
    end
  end
end