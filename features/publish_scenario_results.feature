Feature: Publish scenario results
  In order to allow users to see the history of a particular scenario
  As a developer
  I want the belly gem to publish the results of each scenario to the belly service
  
  Background:
    Given a standard Cucumber project directory structure
    And a file named "features/support/belly.rb" with:
      """
      require 'belly/for/cucumber'
      
      """
      
    And a file named "features/step_definitions/foo_steps.rb" with:
      """
      When /pass/ do
      end

      When /fail/ do
        raise("FAIL")
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
      Feature: Passing Feature
        Scenario: Passing Scenario
          When I pass
    
      """
    When I run cucumber features
    Then the hub should have received a POST to "/test_results" with:
      """
      {
        "id": {
          "feature":"Passing Feature",
          "line":"2",
          "feature_file":"features/foo.feature",
          "scenario":"Passing Scenario"
        },
        "project":"test-project",
        "type":"Belly::Messages::CucumberScenarioResultMessage"
      }
      """

  Scenario: Run a test with a scenario that fails
  And a file named "features/foo.feature" with:
    """
    Feature: Passing Feature
      Scenario: Passing Scenario
        When I pass
    
      Scenario: Failing Scenario
        When I fail
    
    """
    When I run cucumber -r belly -r features -v
    Then the hub should have received a POST to "/test_results" with:
      """
      {
        "project":"test-project",
        "status":"passed"
      }
      """
    And the hub should have received a POST to "/test_results" with:
      """
      {
        "project":"test-project",
        "status":"failed",
        "exception":{
          "message":"FAIL"
        }
      }
      """
