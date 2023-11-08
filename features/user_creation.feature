@web_ui @api
Feature: Example Feature

  Scenario: Verify new user creation on UI
    Given I am on the homepage
    When I navigate to the Registration page
    And I register a new user on UI
    Then I see user is created

