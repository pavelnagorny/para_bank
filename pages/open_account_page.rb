# frozen_string_literal: true

module Pages
  class OpenAccountPage < SitePrism::Page
    element :account_type_dropdown, '#type'
    element :from_account_dropdown, '#fromAccountId'
    element :open_new_account_button, :xpath, '//input[@value="Open New Account"]'
    element :new_account_id_text, '#newAccountId'

    def click_open_account_button
      open_new_account_button.click
    end

    def return_new_account_id
      new_account_id_text.text
    end

    def open_account(type)
      account_type_dropdown.click
      find(:xpath, "//option[text()='#{type}']")
      click_open_account_button
      return_new_account_id
    end
  end
end
