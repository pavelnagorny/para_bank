# frozen_string_literal: true

module Pages
  class OpenAccountPage < SitePrism::Page
    element :account_type_dropdown, '#type'
    element :from_account_dropdown, '#fromAccountId'
    element :open_new_account_button, :xpath, '//input[@value="Open New Account"]'

    def click_open_account_button
      open_new_account_button.click
    end

    def open_account(type)
      account_type_dropdown.click
      find(:xpath, "//option[text()='#{type}']")
      click_open_account_button
    end
  end
end
