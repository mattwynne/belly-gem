require 'rest_client'

module Belly::Client
  class HubProxy
    def initialize(config)
      @config = config
    end
    
    def post_test_result(json_data)
      response = request(:post, '/test_results', json_data, :content_type => :json)
    end
    
    def around_request(&block)
      @around_request_block = block
    end
    
  private
  
    def request(method, path, data, options = {})
      url = @config.url + path
      request_block = lambda { RestClient.send(method, url, data, options) }
      
      response = if @around_request_block
        @around_request_block.call(request_block)
      else
        request_block.call
      end
      
      unless response.code == "200"
        raise("Failed to talk to belly hub: Response #{response.code} #{response.message}: #{response.body}") 
      end
      
      response
    end
  end
end