require 'aruba'

module RequestsHelper
  def requests
    @hub.requests.map do |r|
      result = r.dup
      result["data"] = JSON.parse(r["data"])
      result
    end
  end
end

World(RequestsHelper)

Given /^there is a hub running on localhost:12345$/ do
  @hub = Belly::FakeHub.run(12345)
end

Then /^the hub should have received a POST to "([^"]*)" with:$/ do |path, data|
  requests.any? do |request|
    request["type"] == "POST" &&
      request["path"] == path &&
      request["data"] == JSON.parse(data)
  end.should be_true
end