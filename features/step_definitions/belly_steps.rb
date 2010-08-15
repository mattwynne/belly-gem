require 'aruba'

module RequestsHelper
  def requests
    @hub.requests.map do |r|
      result = r.dup
      result["data"] = JSON.parse(r["data"])
      result
    end
  end
  
  def start_hub!
    @hub = Belly::FakeHub.run(12345)
  end
end

World(RequestsHelper)

Given /^there is a hub running on localhost:12345$/ do
  start_hub!
end

Given /^Belly has been installed in the features$/ do
  start_hub!
  create_file "features/support/belly.rb", <<-EOF
require 'belly/for/cucumber'
EOF
  create_file ".belly", <<-EOF
hub: localhost:12345
project: test-project
EOF
end

Then /^the hub should have received a POST to "([^"]*)" with:$/ do |path, data|
  requests.any? do |request|
    request["type"] == "POST" &&
      request["path"] == path &&
      request["data"] == JSON.parse(data)
  end.should be_true
end

Then /^the hub should have received a test result$/ do
  unless(requests.any? { |r| r["type"] == "POST" && r["path"] == "/test_results" })
    raise("Couldn't find any test_results POST requests in:\n\n #{requests.inspect}")
  end
end
