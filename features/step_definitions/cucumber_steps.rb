Given /^a standard Cucumber project directory structure$/ do
  in_current_dir do
    FileUtils.rm_rf 'features' if File.directory?('features')
    FileUtils.mkdir_p 'features/support'
    FileUtils.mkdir 'features/step_definitions'
  end
end
