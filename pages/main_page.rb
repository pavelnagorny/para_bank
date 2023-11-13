# frozen_string_literal: true

module Pages
  class MainPage < SitePrism::Page
    element :open_account_button, :xpath, '//a[text()="Open New Account"]'
    element :accounts_overview_button, :xpath, '//a[text()="Accounts Overview"]'
    element :transfer_funds_button, :xpath, '//a[text()="Transfer Funds"]'
    element :bill_pay_button, :xpath, '//a[text()="Bill Pay"]'

    def click_open_account_button
      open_account_button.click
    end

    def click_accounts_overview_button
      accounts_overview_button.click
    end

    def click_transfer_funds_button
      transfer_funds_button.click
    end

    def click_bill_pay_button
      bill_pay_button.click
    end
  end
end
