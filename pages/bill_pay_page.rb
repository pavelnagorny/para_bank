# frozen_string_literal: true

module Pages
  class BillPayPage < SitePrism::Page
    element :payee_name_field, :xpath, '//input[@name="payee.name"]'
    element :payee_address_field, :xpath, '//input[@name="payee.address.street"]'
    element :payee_city_field, :xpath, '//input[@name="payee.address.city"]'
    element :payee_state_field, :xpath, '//input[@name="payee.address.state"]'
    element :payee_zip_code_field, :xpath, '//input[@name="payee.address.zipCode"]'
    element :payee_phone_field, :xpath, '//input[@name="payee.phoneNumber"]'
    element :payee_account_field, :xpath, '//input[@name="payee.accountNumber"]'
    element :payee_verify_account_field, :xpath, '//input[@name="verifyAccount"]'
    element :amount_field, :xpath, '//input[@name="amount"]'
    element :from_account_dropdown, :xpath, '//select[@name="fromAccountId"]'
    element :send_payment, :xpath, '//input[@value="Send Payment"]'

    def fill_out_bill_payment_form(payee, from_account, amount)
      payee_name_field.set(payee.firstname)
      payee_address_field.set(payee.address)
      payee_city_field.set(payee.city)
      payee_state_field.set(payee.state)
      payee_zip_code_field.set(payee.zip)
      payee_phone_field.set(payee.phone_number)
      payee_account_field.set(payee.account_ids.first)
      payee_verify_account_field.set(payee.account_ids.first)
      amount_field.set(amount)
      from_account_dropdown.click
      find(:xpath, "//option[@value = #{from_account}]").click
    end

    def pay_a_bill(payer, payee, amount)
      from_account = payer.account_ids[0]
      fill_out_bill_payment_form(payee, from_account, amount)
      send_payment.click
    end
  end
end
