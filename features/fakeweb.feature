@announce
Feature: Fakeweb
  In order to work on a codebase that uses Fakeweb, 
  belly needs to disable Fakeweb during it's own net communication

  Scenario: Features have FakeWeb enabled with allow_net_connect = false
    Given a Cucumber test suite with a single passing scenario
    And Belly has been installed in the features
    And a file named "features/support/fake_web.rb" with:
      """
      require 'fake_web'
      FakeWeb.allow_net_connect = false
      
      """
    When I run the features
    Then it should pass
    And the hub should have received a test result
