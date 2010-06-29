require 'aruba'

Given /^there is a belly\-hub running on localhost:12345$/ do
  @hub = Belly::FakeHub.new(12345)
end

Then /^the belly\-hub should have received the following requests:$/ do |table|
  table.map_column!('data') do |raw_data|
    JSON.parse(raw_data)
  end
  table.diff! @hub.requests
end