require 'aruba'

Given /^there is a belly\-hub running on localhost:12345$/ do
  @hub = Belly::FakeHub.new(12345)
end

Then /^the belly\-hub should have received the following requests:$/ do |table|
  requests = @hub.requests.map do |r|
    result = r.dup
    result["data"] = JSON.parse(r["data"])
    result
  end
  
  table.map_column!('data') do |raw_data|
    JSON.parse(raw_data)
  end
  
  table.diff! requests
end