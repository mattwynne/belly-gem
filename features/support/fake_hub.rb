require 'sinatra/base'
require 'json'
require 'open-uri'

module Belly
  class FakeHub
    class << self
      def run(port)
        return @instance if @instance
        @instance = new(port)
      end
    end
    
    class App < Sinatra::Base
      module Requests
        class << self
          def all
            @requests ||= []
          end
          
          def clear!
            @requests = []
          end
        end
      end
      
      get '/requests' do
        Requests.clear! if params['delete']
        Requests.all.to_json
      end
      
      post '*' do
        Requests.all << { 
          'type' => env['REQUEST_METHOD'], 
          'path' => env["PATH_INFO"],
          'data' => request.body.read 
        }
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
    
    def clear_requests!
      open("http://localhost:#{@port}/requests?delete=yeah")
    end
  end
end

After do
  @hub.clear_requests!
end