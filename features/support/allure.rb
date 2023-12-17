# frozen_string_literal: true

require 'allure-cucumber'

AllureCucumber.configure do |config|
  config.results_directory = 'reports/allure-results'
end

# Generate Allure report
at_exit do
  system('allure generate reports/allure-results --clean')
end
