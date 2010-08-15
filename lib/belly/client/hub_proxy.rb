require 'net/http'
require 'uri'

module Belly::Client
  class HubProxy
    def initialize(config)
      @config = config
    end
    
    def post_test_result(data)
      request = Net::HTTP::Post.new(@config.url + '/test_results', {'Content-Type' =>'application/json'})
      request.body = data
      response = Net::HTTP.new(@config.host, @config.port).start do |http| 
        if @around_request_block
          block = Proc.new { http.request(request) }
          @around_request_block.call(block)
        else
          http.request(request)
        end
      end
      unless response.code == "200"
        raise("Failed to talk to belly hub: Response #{response.code} #{response.message}: #{response.body}") 
      end
    end
    
    def around_request(&block)
      @around_request_block = block
    end
  end
end