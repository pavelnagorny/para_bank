require 'capybara'
require 'capybara/cucumber'
require 'site_prism'

Capybara.default_driver = :selenium # You can change this based on your preferred browser driver
Capybara.app_host = 'https://example.com' # Replace with the base URL of your application

World(Capybara::DSL)

