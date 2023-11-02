# frozen_string_literal: true

require_relative '../../models/user'

user_created = false

Before do |scenario|
  LOGGER.info "Current test case dwells in #{scenario.location}"
end

Before do
  clean_up_data('reports', %w[png yml])
end

Before do
  LOGGER.info "Creating browser session"
  Support::BrowserUtils.create_session
end

Before do
  unless user_created
    USER = Models::User.new
    save_to_file(USER.to_hash)
  end
  LOGGER.info "Creating user: #{USER}"
  user_created = true
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
