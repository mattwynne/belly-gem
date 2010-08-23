require 'rest_client'

module Belly::Client
  class HubProxy
    def initialize(config)
      @config = config
    end
    
    def post_test_result(json_data)
      request(:post, '/test_results', json_data, :content_type => :json)
    end
    
    def get_failing_scenarios_for_project_named(project_name)
      project_id = get_project_id_by_name(project_name)
      rerun_statuses = [:pending, :undefined, :failed]
      status_querystring = rerun_statuses.map { |s| "status[]=#{s}"}.join("&")
      response = request(:get, "/projects/#{project_id}/cucumber_scenarios.json?#{status_querystring}")
      JSON.parse(response)["cucumber_scenarios"]
    end
    
    def get_project_id_by_name(project_name)
      response = request(:get, "/projects.json?name=#{project_name}")
      projects = JSON.parse(response)["projects"]
      raise("Couldn't find a project named #{project_name}") unless projects.any?
      projects.first["id"].to_i
    end
    
    def around_request(&block)
      @around_request_block = block
    end
    
  private
  
    def request(method, path, data = nil, options = nil)
      url = @config.url + path
      args = [url]
      args << data if data
      args << options if options
      Belly.log("Sending #{method} request to #{url}")
      request_block = lambda { RestClient.send(method, *args) }
      
      response = if @around_request_block
        @around_request_block.call(request_block)
      else
        request_block.call
      end
      
      unless response.code == 200
        raise("Failed to talk to belly hub: Response #{response.code} #{response.message}: #{response.body}") 
      end
      
      Belly.log("response: #{response}")
      
      response
    end
  end
end