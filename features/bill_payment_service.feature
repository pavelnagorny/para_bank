@web_ui @api
Feature: Example Feature

  Scenario: Verify user can pay a bill with valid payee information
    When I register a 'user 1' on API
    And I retrieve account IDs for 'user 1' user on API
    And I am on the homepage
    And I navigate to the Registration page
    And I register a 'user 2' on UI
    And I navigate to the Accounts Overview page
    And I retrieve all 'user 2' account ids
    And I navigate to the Bill Pay page
    And I pay 100 from 'user_2' to 'user_1' account
    Then I see bill payment was successful
