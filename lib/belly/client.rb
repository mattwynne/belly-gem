require 'net/http'
require 'uri'

module Belly
  class Client
    def initialize(config)
      @url = config.url
    end
    
    def add_scenario(data)
      Net::HTTP.post_form(URI.parse(@url + '/scenarios'), data)
    end
  end
end