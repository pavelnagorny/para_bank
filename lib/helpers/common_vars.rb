# frozen_string_literal: true

module CommonVars
  BASE_URL = "http://#{ENV.fetch('PLATFORM')}:8080/parabank".freeze
  INDEX_API_HOST = '/parabank/index.htm'
  LOGIN_API_HOST = '/parabank/login.htm'
  REGISTER_API_HOST = '/parabank/register.htm'
  OVERVIEW_API_HOST = '/parabank/overview.htm'
  CUSTOMERS_API_HOST = '/parabank/services/bank/customers/'
  API_HEADERS = { 'content-type': 'application/x-www-form-urlencoded' }.freeze
end
