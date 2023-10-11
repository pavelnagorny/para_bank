# frozen_string_literal: true

require_relative '../../models/user'

user_created = false

Before do
  # Define the path to the reports folder
  reports_folder = 'reports'
  # Clean up screenshot files
  clean_up_data(reports_folder, %w[png yml])
end

Before do
  Support::BrowserUtils.create_session
end

Before do
  unless user_created
    USER = Models::User.new
    save_to_file(USER.to_hash)
  end
  user_created = true
end

After do |scenario|
  screen_path = "reports/scr/#{Time.now.strftime('%Y-%m-%d_%H:%M:%S')}_#{scenario.name}_error.png"
  Capybara.save_screenshot(screen_path) if scenario.failed?
  Capybara.reset_session!
end
