# frozen_string_literal: true

When('I register a {parameter} on API') do |user|
  instance_variable_set("@#{user}", generate_user_data)
  @users ||= []
  new_user = instance_variable_get("@#{user}")
  @users << new_user
  new_user_payload = FactoryBot.build(:new_user_registration_payload, user: new_user)

  @api_client.api_register_new_user(new_user_payload)
end

When('I sign in as s {variable} on API') do |user|
  @api_client.api_client_auth(user)

  @customer_id = @api_client.extract_customer_id_from_html
  LOGGER.info "Logged in user_id: #{@customer_id}"
end

Given('I create random account for {variable} user on API') do |user|
  @customer_id = @api_client.retrieve_customer_id
  account_id = retrieve_user_account_ids(@customer_id).first
  body = {
    'customerId' => @customer_id,
    'newAccountType' => rand(0..1).to_s,
    'fromAccountId' => account_id
  }
  @api_client.api_client_post_with_params(path: '/parabank/services/bank/createAccount',
                                          params: body,
                                          additional_headers: { 'Content-Type' => 'application/json' })
  new_account_id = @api_client.parse_xml.at('account/id').content
  user.account_ids = retrieve_user_account_ids(@customer_id)

  LOGGER.info "Base account ID: #{account_id}\nNew account ID: #{new_account_id}"
end

Given('I retrieve account IDs for {variable} user on API') do |user|
  @customer_id = @api_client.retrieve_customer_id
  user.account_ids = retrieve_user_account_ids(@customer_id)

  LOGGER.info "All user account IDs: #{user.account_ids}"
end

def retrieve_user_account_ids(customer_id)
  account_ids = []
  @api_client.api_client_get(path: "#{CommonVars::CUSTOMERS_API_HOST}#{customer_id}/accounts")
  @api_client.parse_xml.xpath('//account/id').each do |id_node|
    account_ids << id_node.content
  end
  account_ids
end
