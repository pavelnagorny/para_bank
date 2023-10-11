require_relative '../spec_helper'

describe 'API Tests' do
  it 'should return 200 OK for GET request' do
    response = RestClient.get('https://api.example.com/data')
    expect(response.code).to eq(200)
  end
end

