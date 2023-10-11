Feature: Example Feature

  Scenario: Verify homepage content
    Given I am on the homepage
    When I click on "About Us"
    Then I should see "Our Story"

Feature: API Example Feature

  Scenario: Verify API response status code
    Given I send a GET request to "https://api.example.com/data"
    Then the response status code should be 200

Feature: Mobile App Example Feature

  Scenario: Verify mobile app functionality
    Given I am on the mobile app homepage
    When I tap on element with id "some_element_id"
    Then I should see text "Expected Text"
