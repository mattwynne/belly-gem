Feature: Publish scenario results
  In order to allow users to see the history of a particular scenario
  As a developer
  I want the belly gem to publish the results of each scenario to the belly service
  
  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/support/belly.rb" with:
      """
      require 'belly' rescue puts("Could not load belly - do you need to install the gem?")
      
      """
      
    And a file named "features/step_definitions/foo_steps.rb" with:
      """
      Given /^I am a rock$/ do
      end

      Given /^I am thin ice$/ do
        raise("yikes")
      end
      
      """
    And a file named ".belly" with:
      """
      hub: localhost:12345
      
      """
    And there is a belly-hub running on localhost:12345

  Scenario: Run a test with a scenario that passes
    Given a file named "features/foo.feature" with:
      """
      Feature: Test
        Scenario: Solid
          Given I am a rock
    
      """
    When I run cucumber -r belly -r features -v
    And the belly-hub should have received the following requests:
      | type | path       | data                                                           |
      | POST | /scenarios | {"type":"cucumber_scenario_result","status":"passed","id":{"scenario":"Solid","feature":"Test"}} |

  Scenario: Run a test with a scenario that fails
  And a file named "features/foo.feature" with:
    """
    Feature: Test
      Scenario: Solid
        Given I am a rock
    
      Scenario: Shaky
        Given I am thin ice
    
    """
    When I run cucumber -r belly -r features -v
    And the belly-hub should have received the following requests:
      | type | path       | data                                                           |
      | POST | /scenarios | {"status":"passed","id":{"scenario":"Solid","feature":"Test"}} |
      | POST | /scenarios | {"status":"failed","id":{"scenario":"Shaky","feature":"Test"}} |
