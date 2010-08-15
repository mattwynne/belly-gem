require 'net/http'
require 'uri'

module Belly::Client
  class HubProxy
    def initialize(config)
      @config = config
    end
    
    def post_test_result(data)
      url = @config.url + '/test_results'
      
      response = make_request(:post, url, data)
      
      unless response.code == "200"
        raise("Failed to talk to belly hub: Response #{response.code} #{response.message}: #{response.body}") 
      end
    end
    
    def around_request(&block)
      @around_request_block = block
    end
    
  private
  
    def make_request(method, url, data)
      request_block = Proc.new do
        request = Net::HTTP::Post.new(url, {'Content-Type' =>'application/json'})
        request.body = data
        Net::HTTP.new(@config.host, @config.port).start do |http| 
          http.request(request)
        end
      end
      
      if @around_request_block
        @around_request_block.call(request_block)
      else
        request_block.call
      end
    end
  end
end