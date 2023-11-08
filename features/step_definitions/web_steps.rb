# frozen_string_literal: true

Given(/^I am on the homepage$/) do
  @login_page.load
  page.has_button? 'Log In'
end

When(/^I navigate to the Registration page$/) do
  @login_page.click_register_button
  @registration_page = Pages::SignUpPage.new
end

When(/^I register a new user on (UI|API)$/) do |method|
  case method
  when 'UI'
    @registration_page.fill_out_register_form(USER)
    @registration_page.click_register_button
  else
    @api_client.get_reg_token
    @api_client.api_register_new_user(USER)
  end
end


When(/^I navigate to the Open New Account page$/) do
  @main_page.click_open_account
  @open_account_page = Pages::OpenAccountPage.new
end

When(/^I open new (.*?) account$/) do |account_type|
  @open_account_page.open_account(account_type)
end

Then(/^I see user is created$/) do
  expect(page).to have_content("Welcome #{USER.username}")
end

Then(/^I login as a valid user$/) do
  @login_page.login
  expect(page).to have_content("Accounts Overview")
  @main_page = Pages::MainPage.new
end

Then(/^I see the account is open$/) do
  expect(page).to have_content("Congratulations, your account is now open.")
end

And(/^I navigate to the Account Overview page$/) do
  @main_page.click_accounts_overview
end

And(/^I navigate to the Transfer Funds page$/) do
  @main_page.click_transfer_funds
  @transfer_funds_page = Pages::TransferFundsPage.new
end

And(/^I transfer (.*?) to the newly created account$/) do |amount|
  @amount = amount
  @transfer_funds_page.transfer_funds(@amount, @account_id, @new_account_id)
end

Then(/^I see money was transferred$/) do
  expect(page).to have_content("$#{@amount}.00 has been transferred from account ##{@account_id} to account ##{@new_account_id}.")
end