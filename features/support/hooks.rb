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

Before('@android') do
  chromedriver_version = '91.0.4472.101'
  install_dir = '/Users/pnago/RubymineProjects/para_bank/drivers'

  Webdrivers::Chromedriver.required_version = chromedriver_version
  Webdrivers.install_dir = install_dir

  # Check if the ChromeDriver executable exists
  chromedriver_executable = File.join(install_dir, 'chromedriver')
  if File.exist?(chromedriver_executable)
    LOGGER.info "ChromeDriver #{chromedriver_version} is installed in #{install_dir}"
  else
    LOGGER.info "ChromeDriver #{chromedriver_version} is not installed. Downloading..."
    Webdrivers::Chromedriver.update
    LOGGER.info "ChromeDriver #{chromedriver_version} installed!"

  end

  LOGGER.info 'Creating android emulator session'
  Support::BrowserUtils.create_android_session
end

Before('@web_ui') do
  LOGGER.info 'Creating browser session'
  Support::BrowserUtils.create_web_session
  @login_page = Pages::LoginPage.new
end

Before('@api') do
  @api_client = Support::APIClient.new
end

After do |scenario|
  screen_path = "reports/scr/#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}_#{scenario.name}_error.png"
  if scenario.failed?
    LOGGER.error "===>>> FAILED <<<===: Scenario: #{scenario.name}"
    LOGGER.error scenario.exception.message.to_s
    LOGGER.info "Save a screenshot: #{screen_path}"
    Capybara.save_screenshot(screen_path)
    Allure.add_attachment(name: 'Failure screen',
                          source: File.open(screen_path),
                          type: Allure::ContentType::PNG,
                          test_case: true)
  else
    LOGGER.info "===>>> PASSED <<<===: Scenario: #{scenario.name}"
  end
  LOGGER.info 'Reset Capybara session'
  Capybara.reset_session!
end
