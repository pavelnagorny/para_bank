# frozen_string_literal: true

Given(/^I create random account on API$/) do
  @customer_id = @api_client.retrieve_customer_id
  @accounts = @api_client.api_client_get(path: CommonVars::CUSTOMERS_API_HOST+@customer_id + '/accounts')
  @account_id = @api_client.parse_xml.at('account/id').content
  body = {
    'customerId' => @customer_id,
    'newAccountType' => rand(0..1).to_s,
    'fromAccountId' => @account_id
  }
  @api_client.api_client_post_with_params(path: '/parabank/services/bank/createAccount', params: body, additional_headers: { 'Content-Type' => 'application/json' })
  @new_account_id = @api_client.parse_xml.at('account/id').content
end