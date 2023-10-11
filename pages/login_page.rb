# frozen_string_literal: true

module Pages
  class LoginPage < SitePrism::Page
    set_url CommonVars::BASE_URL
    element :login_header, :xpath, '//*[text()="Customer Login"]'
    element :register_button, :xpath, '//a[text()="Register"]'

    def click_register_button
      register_button.click
    end
  end
end
