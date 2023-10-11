Given(/^I am on the homepage$/) do
  visit('/')
end

When(/^I click on "(.*?)"$/) do |element|
  click_on(element)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
