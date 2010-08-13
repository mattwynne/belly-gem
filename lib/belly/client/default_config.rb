module Belly
  class DefaultConfig
    def project
      File.basename(Dir.pwd)
    end
    
    def url
      "http://#{host}:#{port}"
    end
    
    def host
      "belly.heroku.com"
    end
    
    def port
      80
    end
    
    def user
      {
        :name  => git_config('user.name'),
        :email => git_config('user.email')
      }
    end
    
  private
  
    def git_config(value)
      `git config --get #{value}`.strip
    end
  end
end
