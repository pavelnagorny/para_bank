require 'appium_lib'

caps = {
  caps: {
    platformName: 'Android', # or 'iOS'
    deviceName: 'your_device_name',
    app: '/path/to/your/app.apk' # or .ipa for iOS
  },
  appium_lib: {
    wait_timeout: 30
  }
}

Appium::Driver.new(caps, true)
Appium.promote_appium_methods Object

Given(/^I am on the mobile app homepage$/) do
  # Implement your mobile app navigation steps here
end

When(/^I tap on element with id "(.*?)"$/) do |element_id|
  find_element(id: element_id).click
end

Then(/^I should see text "(.*?)"$/) do |text|
  expect(find_element(xpath: "//*[contains(@text, '#{text}')]").displayed?).to be_truthy
end

