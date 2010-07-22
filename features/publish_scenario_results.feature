Feature: Publish scenario results
  In order to allow users to see the history of a particular scenario
  As a developer
  I want the belly gem to publish the results of each scenario to the belly service
  
  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/support/belly.rb" with:
      """
      require 'belly/for/cucumber' rescue puts("Could not load belly - do you need to install the gem?")
      
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
      project: test-project
      
      """
    And there is a hub running on localhost:12345

  @announce
  Scenario: Run a test with a scenario that passes
    Given a file named "features/foo.feature" with:
      """
      Feature: Test
        Scenario: Solid
          Given I am a rock
    
      """
    When I run cucumber features
    Then the hub should have received a POST to "/scenarios" with:
      """
      { 
        "project":"test-project",
        "type":"cucumber_scenario_result",
        "status":"passed",
        "id": {
          "scenario":"Solid",
          "feature":"Test"
        }
      }
      """

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
    Then the hub should have received a POST to "/scenarios" with:
      """
      {
        "project":"test-project",
        "type":"cucumber_scenario_result",
        "status":"passed",
        "id": {"scenario":"Solid","feature":"Test"}
      }
      """
    And the hub should have received a POST to "/scenarios" with:
      """
      {
        "project":"test-project",
        "type":"cucumber_scenario_result",
        "status":"failed",
        "id": {"scenario":"Shaky","feature":"Test"}
      }
      """
