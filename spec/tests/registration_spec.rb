# frozen_string_literal: true

RSpec.describe 'API user registration' do
  let(:user) { init_user }

  before do
    unless prepared_data?
      storage.user = user
      storage.add_user(user)
      storage.api_client = init_api_client
      storage.prepared_data = true
    end
  end

  it 'creates a user with a valid payload' do
    api_reg_payload = FactoryBot.build(:new_user_registration_payload, user:)
    # Perform your API request using the generated payload
    response = api_client.api_register_new_user(api_reg_payload)
    # Add your assertions based on the API response
    expect(response.status).to eq(200)
  end
end
