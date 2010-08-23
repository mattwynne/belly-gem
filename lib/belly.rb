$:.push(File.expand_path(File.dirname(__FILE__)))

module Belly
  class << self
    def log(message)
      return unless ENV['BELLY_LOG']
      puts "* [Belly] #{message}"
    end
    
    def version
      @version ||= File.read(File.dirname(__FILE__) + '/../VERSION').strip
    end
  end
end

Belly.log "Belly version #{Belly.version} starting in #{File.expand_path(File.dirname(__FILE__))}"
