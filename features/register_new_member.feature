Feature: Example Feature

  Scenario: Verify new user creation on UI
    Given I am on the homepage
    When I navigate to the Registration page
    And I register a new user on UI
    When I register a new user on API
    Then I can successfully login as a newly registered user
