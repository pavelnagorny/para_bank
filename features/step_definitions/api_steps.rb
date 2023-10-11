Given(/^I send a GET request to "(.*?)"$/) do |url|
  @response = RestClient.get(url)
end

Then(/^the response status code should be (\d+)$/) do |status_code|
  expect(@response.code).to eq(status_code.to_i)
end

