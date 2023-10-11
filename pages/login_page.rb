# frozen_string_literal: true

require_relative '../features/support/common_vars'

module Pages
  class LoginPage < SitePrism::Page
    set_url CommonVars::BASE_URL
    element :login_header, :xpath, '//*[text()="Customer Login"]'
  end
end
