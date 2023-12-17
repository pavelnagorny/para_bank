# frozen_string_literal: true

module Pages
  class TransferFundsPage < SitePrism::Page
    element :amount_field, '#amount'
    element :from_account_dropdown, '#fromAccountId'
    element :to_account_dropdown, '#toAccountId'
    element :transfer_button, :xpath, '//input[@value="Transfer"]'

    def enter_transfer_amount(amount)
      amount_field.set(amount)
    end

    def select_from_account(account)
      from_account_dropdown.find(:xpath, ".//option[@label=#{account}]").click
    end

    def select_to_account(account)
      to_account_dropdown.find(:xpath, ".//option[@label = #{account}]").click
    end

    def transfer_funds(amount, from_account, to_account)
      enter_transfer_amount(amount)
      select_from_account(from_account)
      select_to_account(to_account)
      transfer_button.click
    end
  end
end
