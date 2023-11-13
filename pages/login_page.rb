# frozen_string_literal: true

module Pages
  class LoginPage < SitePrism::Page
    set_url CommonVars::BASE_URL
    element :login_header, :xpath, '//*[text()="Customer Login"]'
    element :login_button, :xpath, '//input[@value = "Log In"]'
    element :username_field, :xpath, '//input[@name = "username"]'
    element :password_field, :xpath, '//input[@name = "password"]'
    element :register_button, :xpath, '//a[text()="Register"]'

    def click_login_button
      login_button.click
    end

    def login(user)
      username_field.set(user.username)
      password_field.set(user.password)
      click_login_button
    end

    def click_register_button
      register_button.click
    end
  end
end
