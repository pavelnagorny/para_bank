# frozen_string_literal: true

require 'dotenv/load'
require 'active_support/all'
require 'cucumber'
require 'capybara/cucumber'
require 'selenium-webdriver'
require 'excon'
require 'logger'
require 'nokogiri'
require 'require_all'
require 'factory_bot'
require 'simplecov'
require 'site_prism'
require 'yaml'
require 'webdrivers'

require 'capybara'
require 'appium_capybara'

Dotenv.load('config/.env')

require_relative '../../patches/factory_bot/attribute_hash'

Dir["#{File.dirname(__FILE__)}/../../spec/factories/*.rb"].each { |file| require file }

require_all 'features/support'
require_all 'lib'
require_all 'pages'

LOGGER = Logger.new($stdout)
# Set the logging level (DEBUG, INFO, WARN, ERROR, FATAL)
LOGGER.level = Logger::DEBUG

LOGGER.formatter = proc do |severity, datetime, _progname, msg|
  "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity}: #{msg}\n"
end

World(CommonHelper)
World(FactoryBot::Syntax::Methods)
