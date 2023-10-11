# frozen_string_literal: true

module Pages
  class SignUpPage < SitePrism::Page
    element :login_header, :xpath, '//*[text()="Signing up is easy!"]'
    element :first_name_field, '#customer\.firstName'
    element :last_name_field, '#customer\.lastName'
    element :address_field, '#customer\.address\.street'
    element :city_field, '#customer\.address\.city'
    element :state_field, '#customer\.address\.state'
    element :zip_code_field, '#customer\.address\.zipCode'
    element :phone_number_field, '#customer\.phoneNumber'
    element :ssn_field, '#customer\.ssn'
    element :username_field, '#customer\.username'
    element :password_field, '#customer\.password'
    element :confirm_password_field, '#repeatedPassword'
    element :register_button, :xpath, '//input[@value = "Register"]'

    def fill_out_register_form(user)
      first_name_field.set user.firstname
      last_name_field.set user.lastname
      address_field.set user.address
      city_field.set user.city
      state_field.set user.state
      zip_code_field.set user.zip
      phone_number_field.set user.phone_number
      ssn_field.set user.ssn
      username_field.set user.username
      password_field.set user.password
      confirm_password_field.set user.password
    end

    def click_register_button
      register_button.click
    end
  end
end
