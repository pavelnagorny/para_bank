# frozen_string_literal: true

Before do |scenario|
  LOGGER.info "Current test case dwells in #{scenario.location}"
end

Before do
  LOGGER.info "Creating browser session"
  Support::BrowserUtils.create_session
end

Before('@web_ui') do
  @login_page = Pages::LoginPage.new
end

Before('@api') do
  @api_client = Support::APIClient.new
end

After do |scenario|
  screen_path = "reports/scr/#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}_#{scenario.name}_error.png"
  if scenario.failed?
    LOGGER.info "Save screenshot to the folder: #{screen_path}"
    Capybara.save_screenshot(screen_path)
  end
  LOGGER.info "Reset Capybara session"
  Capybara.reset_session!
end
