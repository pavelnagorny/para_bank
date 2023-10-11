# frozen_string_literal: true

Given(/^I am on the homepage$/) do
  @login_page = Pages::LoginPage.new
  @login_page.load
end

When(/^I navigate to the Registration page$/) do
  @login_page.click_register_button
  @register_page = Pages::SignUpPage.new
end

When(/^I register a new user on (UI|API)$/) do |method|
  case method
  when 'UI'
    @register_page.fill_out_register_form(USER)
    @register_page.click_register_button

    expect(page).to have_content("Welcome #{USER.username}")
  else
    @api_client = Support::APIClient.new
    @api_client.get_reg_token
    @api_client.api_register_new_user(USER)
  end
end

Then(/I can successfully login as a newly registered user/) do
  @api_client = Support::APIClient.new
  @api_client.get_api_token
  @api_client.api_client_auth(USER.username, USER.password)
  @api_client.api_client_get(path: CommonVars::OVERVIEW_API_HOST)
  @use_id = @api_client.parse_html.at_xpath("//script[contains(text(), 'services_proxy/bank/customers/')]")
                       .text.scan(/(\d+) \+ "\/accounts"/)[0][0]

  @api_client.api_client_get(path: "parabank/services_proxy/bank/customers/#{@use_id}/accounts")
end

