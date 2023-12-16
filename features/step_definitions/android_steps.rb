# frozen_string_literal: true

Given('I open the main page in browser') do
  visit 'http://10.0.2.2:8080/parabank'
end

Then('I should see the {string} text') do |text|
  expect(page).to have_text text
end
