Feature: Publish scenario results
  In order to allow users to see the history of a particular scenario
  As a developer
  I want the belly gem to publish the results of each scenario to the belly service
  
  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/foo.feature" containing:
      """
      Scenario: Solid
        Given I am a rock
      
      Scenario: Shaky
        Given I am thin ice
      
      """
    And a file named ".belly" containing
      """
      hub: localhost:12345
      
      """
    And there is a belly-hub running on localhost:12345

  Scenario: run a test
    And a file named "step_definitions/foo_steps.rb" containing:
      """
      Given /I am a rock/ do
      end
      
      Given /I am thin ice/ do
        raise "crack"
      end
      """
    When I run cucumber -f Belly::Formatter features
    Then the belly-hub should have received the following scenarios:
      | name  | status  |
      | Solid | Success |
      | Shaky | Failed  |
