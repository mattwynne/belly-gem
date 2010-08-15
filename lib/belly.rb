$:.push(File.expand_path(File.dirname(__FILE__)))

module Belly
  class << self
    def log(message)
      return unless ENV['BELLY_LOG']
      puts "* [Belly] #{message}"
    end
  end
end

require 'belly/client'