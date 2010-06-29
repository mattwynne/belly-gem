Feature: Publish scenario results
  In order to allow users to see the history of a particular scenario
  As a developer
  I want the belly gem to publish the results of each scenario to the belly service
  
  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/foo.feature" with:
      """
      Feature: Test
        Scenario: Solid
          Given I am a rock
      
        Scenario: Shaky
          Given I am thin ice
      
      """
    And a file named ".belly" with:
      """
      hub: localhost:12345
      
      """
    And there is a belly-hub running on localhost:12345

  Scenario: run a test
    And a file named "features/step_definitions/foo_steps.rb" with:
      """
      require 'belly'
      Given /^I am a rock$/ do
      end

      Given /^I am thin ice$/ do
        raise("yikes")
      end
      
      """
    When I run "cucumber -r features -v"
    Then I should see exactly ""
    And the belly-hub should have received the following requests:
      | type | path       | data                                                                   |
      | POST | /scenarios | { "id": { "feature": "Test", "scenario": "Solid"}, "status":"passed" } |
      | POST | /scenarios | { "id": { "feature": "Test", "scenario": "Shaky"}, "status":"failed" } |
