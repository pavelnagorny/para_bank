# frozen_string_literal: true

reports_removed = false

Before do
  unless reports_removed
    clean_up_data('reports', %w[png yml])
    reports_removed = true
  end
end

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
    LOGGER.error "===>>> FAILED <<<===: Scenario: #{scenario.name}"
    LOGGER.error   "#{scenario.exception.message}"
    LOGGER.info "Save a screenshot: #{screen_path}"
    Capybara.save_screenshot(screen_path)
  else
    LOGGER.info "===>>> PASSED <<<===: Scenario: #{scenario.name}"
  end
  LOGGER.info "Reset Capybara session"
  Capybara.reset_session!
end
