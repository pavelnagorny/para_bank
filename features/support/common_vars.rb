# frozen_string_literal: true

module CommonVars
  BASE_URL = 'http://host.docker.internal:8080/parabank'
  INDEX_API_HOST = '/parabank/index.htm'
  LOGIN_API_HOST = '/parabank/login.htm'
  REGISTER_API_HOST = '/parabank/register.htm'
  OVERVIEW_API_HOST = '/parabank/overview.htm'
  API_HEADERS = { 'content-type': 'application/x-www-form-urlencoded' }.freeze
end
