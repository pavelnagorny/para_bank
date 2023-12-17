# frozen_string_literal: true

Given(/^I am on the homepage$/) do
  @login_page.load
  page.has_button? 'Log In'
end

When(/^I navigate to the Registration page$/) do
  @login_page.click_register_button
  @registration_page = Pages::SignUpPage.new
end

When('I register a {parameter} on UI') do |user|
  instance_variable_set("@#{user}", generate_user_data)
  @users ||= []
  new_user = instance_variable_get("@#{user}")
  @users << new_user

  @registration_page.fill_out_register_form(new_user)
  @registration_page.click_register_button
  @main_page = Pages::MainPage.new
end

When(/^I navigate to the Open New Account page$/) do
  @main_page.click_open_account_button
  @open_account_page = Pages::OpenAccountPage.new
end

When('I open new {string} account') do |account_type|
  @account_id = @open_account_page.open_account(account_type)

  LOGGER.info "New account id: #{@account_id}"
end

Then('I see {variable} is created') do |user|
  expect(page).to have_content("Welcome #{user.username}")

  LOGGER.info "Created user: #{user.username}"
end

Then('I login as a {variable}') do |user|
  @login_page.login(user)
  @main_page = Pages::MainPage.new
  expect(page).to have_content('Accounts Overview')
end

Then(/^I see the account is open$/) do
  expect(page).to have_content('Congratulations, your account is now open.')
end

And(/^I navigate to the Accounts Overview page$/) do
  @main_page.click_accounts_overview_button
  @accounts_overview_page = Pages::AccountsOverviewPage.new
end

And(/^I navigate to the Transfer Funds page$/) do
  @main_page.click_transfer_funds_button
  @transfer_funds_page = Pages::TransferFundsPage.new
end

And(/^I navigate to the Bill Pay page$/) do
  @main_page.click_bill_pay_button
  @bill_pay_page = Pages::BillPayPage.new
end

And('I transfer {int} to the newly created account for {variable} user') do |amount, user|
  @amount = amount
  @transfer_funds_page.transfer_funds(@amount, user.account_ids.first, user.account_ids.last)
end

Then(/^I see money was transferred$/) do
  expect(page).to have_content("$#{@amount}.00 has been transferred from account " \
                               "##{@user.account_ids.first} to account ##{@user.account_ids.last}.")

  LOGGER.info "$#{@amount}.00 has been transferred from account " \
              "##{@user.account_ids.first} to account ##{@user.account_ids.last}."
end

And('I retrieve all {variable} account ids') do |user|
  account_ids = @accounts_overview_page.return_all_accounts
  user.account_ids = account_ids

  LOGGER.info "All user account IDs: #{user.account_ids}"
end

And('I pay {int} from {variable} to {variable} account') do |amount, from_user, to_user|
  @amount = amount
  @bill_pay_page.pay_a_bill(from_user, to_user, @amount)
end

Then(/^I see bill payment was successful$/) do
  expect(page).to have_content("Bill Payment to #{@user_1.firstname} in the amount of $#{@amount}.00 from account " \
                               "#{@user_2.account_ids.first} was successful.")

  LOGGER.info "Bill Payment from account #{@user_2.account_ids.first} was successful."
end
