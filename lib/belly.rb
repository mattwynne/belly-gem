begin
 Cucumber
rescue NameError
  raise LoadError, "You've tried to require the belly gem from somewhere that doesn't seem to be a Cucumber test suite. I'm afraid I can't handle that at the moment."
end

module Belly
  def self.log(message)
    return unless ENV['BELLY_LOG']
    puts "* [Belly] #{message}"
  end
end

require 'belly/cucumber/hooks'
