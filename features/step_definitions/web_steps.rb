# frozen_string_literal: true
require_relative '../../pages/login_page'

Given(/^I am on the homepage$/) do
  @login_page = Pages::LoginPage.new
  @login_page.load
end

When(/^I click on "(.*?)"$/) do |element|
  click_on(element)
end

Then(/^I should see "(.*?)"$/) do |text|
  expect(page).to have_content(text)
end
