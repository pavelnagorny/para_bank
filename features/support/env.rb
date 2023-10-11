require 'capybara'
require 'capybara/cucumber'
require 'excon'
require 'logger'
require 'nokogiri'
require 'require_all'
require 'selenium-webdriver'
require 'site_prism'
require 'yaml'

require_all 'features/support'
require_all 'pages'
require_all 'models'

LOGGER = Logger.new(STDOUT)
# Set the logging level (DEBUG, INFO, WARN, ERROR, FATAL)
LOGGER.level = Logger::DEBUG

LOGGER.formatter = proc do |severity, datetime, _progname, msg|
  "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity}: #{msg}\n"
end

World(CommonHelpers)
