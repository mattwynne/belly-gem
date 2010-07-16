require 'belly'

Before do |scenario|
  Belly.log %{about to run scenario "#{scenario.name}"}
end

After do |scenario|
  Belly.log %{result: #{scenario.status}}
  Belly.publish(scenario)
end

Belly.log("Installed Cucumber hooks")
