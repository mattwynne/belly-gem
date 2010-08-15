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

Given /^a Cucumber test suite with a single passing scenario$/ do
  FileUtils.mkdir_p 'features/support'
  FileUtils.mkdir_p 'features/step_definitions'
  create_file 'features/step_definitions/steps.rb', <<-EOF
When /pass/ do
end
EOF

  create_file "features/pass.feature", <<-EOF
Feature: Passing Feature
  Scenario: Passing Scenario
    When I pass
EOF
end

When /^I run the features$/ do
  When "I run cucumber features"
end

Then /^it should pass$/ do
  Then "the exit status should be 0"
end