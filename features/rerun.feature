Feature: Rerun
  In order to close the loops
  As a programmer
  I want belly to remember all the tests I've run that have failed
  
  Scenario: title
    Given a standard Cucumber project directory structure
    And a file named "features/support/belly.rb" with:
      """
      require 'belly/for/cucumber' rescue puts("Could not load belly - do you need to install the gem?")
      
      """
    And there is a hub running on localhost:12345
    And a file named ".belly" with:
      """
      hub: localhost:12345
      project: test-project
      
      """
    And a file named "features/fail.feature" with:
      """
      Feature: Fail
        Scenario: Boom
          Given I fail
      
      """
    And a file named "features/step_definitions/fail.rb" with:
      """
      Given /fail/ do
        raise "We are failing"
      end
      
      """
    When I run "cucumber features"
    And I run "belly rerun:cucumber"
    Then it should pass with:
      """
      features/foo.feature:
      
      """
  
  
  