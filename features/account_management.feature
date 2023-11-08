@web_ui @api
Feature: Example Feature

  Scenario Outline: Verify new user can open the account
    When I register a new user on API
    And I am on the homepage
    And I login as a valid user
    And I navigate to the Open New Account page
    And I open new <account_type> account
    Then I see the account is open

    Examples:
      | account_type |
      | CHECKING     |
      | SAVINGS      |

  Scenario: Verify new user can transfer funds between accounts
    When I register a new user on API
    And I create random account on API
    And I am on the homepage
    And I login as a valid user
    And I navigate to the Transfer Funds page
    And I transfer 100 to the newly created account
    Then I see money was transferred

