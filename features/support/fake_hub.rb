require 'sinatra/base'
require 'json'
require 'open-uri'

module Belly
  class FakeHub
    class App < Sinatra::Base
      module Requests
        class << self
          def all
            @requests ||= []
          end
          
          def add(data)
            all << data
          end
        end
      end
      
      get '/requests' do
        Requests.all.to_json
      end
      
      post '*' do
        path = params.delete('splat').join
        Requests.add({ 'type' => 'POST', 'path' => path, 'data' => params})
        ''
      end
      
    end
    
    def initialize(port)
      @port = port
      @runner = Thread.new do
        App.run! :host => 'localhost', :port => port
      end
    end
    
    def requests
      JSON.parse(open("http://localhost:#{@port}/requests").read)
    end
  end
end