require 'cucumber'
require 'tempfile'

module CucumberStepsHelper
  attr_reader :last_stderr
  
  def working_dir
    File.join(File.dirname(__FILE__), '/../../tmp')
  end
  
  def in_current_dir(&block)
    Dir.chdir(@current_dir, &block)
  end
  
  def create_file(file_name, file_content)
    in_current_dir do
      FileUtils.mkdir_p(File.dirname(file_name)) unless File.directory?(File.dirname(file_name))
      File.open(file_name, 'w') { |f| f << file_content }
    end
  end
  
  def run(command)
    stderr_file = Tempfile.new('cucumber')
    stderr_file.close
    in_current_dir do
      mode = Cucumber::RUBY_1_9 ? {:external_encoding=>"UTF-8"} : 'r'
      IO.popen("#{command} 2> #{stderr_file.path}", mode) do |io|
        @last_stdout = io.read
      end

      @last_exit_status = $?.exitstatus
    end
    @last_stderr = IO.read(stderr_file.path)
  end
end

World CucumberStepsHelper

Before do
  FileUtils.rm_rf working_dir
  FileUtils.mkdir_p working_dir
end

Given /^a standard Cucumber project directory structure$/ do
  @current_dir = working_dir
  in_current_dir do
    FileUtils.mkdir_p 'features/support'
    FileUtils.mkdir 'features/step_definitions'
  end
end

Given /^a file named "([^\"]*)" with:$/ do |file_name, file_content|
  create_file(file_name, file_content)
end

When /^I run cucumber (.*)$/ do |cucumber_opts|
  run "#{Cucumber::RUBY_BINARY} -I#{belly_lib_path} #{Cucumber::BINARY} --no-color #{cucumber_opts}"
end

Then /^STDERR should be empty$/ do
  last_stderr.should == ""
end