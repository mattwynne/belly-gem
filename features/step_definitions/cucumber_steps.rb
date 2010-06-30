Given /^a standard Cucumber project directory structure$/ do
  in_current_dir do
    FileUtils.rm_rf 'features' if File.directory?('features')
    FileUtils.mkdir_p 'features/support'
    FileUtils.mkdir 'features/step_definitions'
  end
end

When /^I run cucumber (.*)$/ do |cucumber_opts|
  cmd = "#{Cucumber::RUBY_BINARY} -I#{belly_lib_path} #{Cucumber::BINARY} --no-color #{cucumber_opts}"
  run(cmd, false)
end
