@android
Feature: Android Appium Test

  Scenario: Open Chrome Browser on Emulator
    Given I open the main page in browser
    Then I should see the 'Customer Login' text
