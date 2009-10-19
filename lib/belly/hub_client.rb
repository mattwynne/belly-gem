require 'net/http'
require 'uri'

module Belly
  class HubClient
    def initialize(host, port)
      @url = "http://#{host}:#{port}"
    end
    
    def add_scenario(data)
      Net::HTTP.post_form(URI.parse(@url + '/scenarios'), data)
    end
  end
end