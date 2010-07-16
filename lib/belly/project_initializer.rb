require 'belly/user_credentials'
require 'belly/client'

module Belly
  class ProjectInitializer
    def initialize(options, ui)
      project_name = options[:name] or raise("Need a :name in the options")
      @uri = "/projects/#{project_name}"
      @ui = ui
    end
    
    def run
      client.get(@uri, self)
    end
    
    def not_found
      client.put(@uri)
    end
    
    def not_authorized
      @ui.die("You don't have access to this project. You'll need to contact one of the project's collaborators and ask them to give you access.")
    end
    
    private
    
    def client
      @client ||= Client.new(Belly.user_credentials)
    end
  end
end
