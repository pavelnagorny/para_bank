# frozen_string_literal: true

require 'allure-cucumber'

AllureCucumber.configure do |c|
  c.logging_level = Logger::INFO
  c.clean_results_directory = true
end

# Generate Allure report
at_exit do
  system('allure serve reports/allure-results -h localhost')
end
