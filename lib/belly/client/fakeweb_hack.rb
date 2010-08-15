module Belly
  class << self
    def install_fakeweb_hack_if_necessary
      return if @fakeweb_hack_installed
      
      FakeWeb.class_eval do
        def self.allow_net_connect?
          return true if Thread.current == @overriding_thread
          @allow_net_connect
        end

        def self.allowing_net_connect_in_this_thread
          @overriding_thread = Thread.current
          result = yield
          @overriding_thread = nil
          result
        end
      end
    end
  end
end

Belly.hub.around_request do |block|
  if defined?(FakeWeb)
    Belly.install_fakeweb_hack_if_necessary
    FakeWeb.allowing_net_connect_in_this_thread(&block)
  else
    block.call
  end
end