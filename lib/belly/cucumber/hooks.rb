Before do |scenario|
  feature_name = scenario.feature.name.split("\n").first # TODO: only needed for older cucumbers
  id = { :feature => feature_name, :scenario => scenario.name }
  Belly.log %{about to run scenario "#{id.to_json}"}
end

After do |scenario|
  Belly.log %{result: #{scenario.status}}
end