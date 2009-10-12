$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../lib')
require 'belly/client'

require 'spec/expectations'

module BellyWorld
  def belly_lib_path
    File.expand_path(File.dirname(__FILE__) + '/../../lib')
  end
end

World BellyWorld