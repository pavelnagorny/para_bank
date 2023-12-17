# frozen_string_literal: true

require 'dotenv/load'
require 'factory_bot'
require 'rspec'
require 'excon'
require 'logger'
require 'require_all'

require_relative '../patches/factory_bot/attribute_hash'

Dotenv.load('config/.env')

LOGGER = Logger.new($stdout)
LOGGER.level = Logger::DEBUG
LOGGER.formatter = proc do |severity, datetime, _progname, msg|
  "#{datetime.strftime('%Y-%m-%d %H:%M:%S')} #{severity}: #{msg}\n"
end

require_all 'spec'
require_all 'spec'
require_all 'lib'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end
