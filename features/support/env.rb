$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')

require 'aruba'
bin_dir = File.expand_path(File.dirname(__FILE__) + '/../../bin/')
ENV["PATH"] = bin_dir + ":" + ENV["PATH"]

# require 'spec/expectations'

module BellyWorld
  def belly_lib_path
    File.expand_path(File.dirname(__FILE__) + '/../../lib')
  end
end

World(BellyWorld)