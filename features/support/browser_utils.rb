# frozen_string_literal: true

module Support
  class BrowserUtils
    class << self
      def initialize_driver(options)
        Capybara.register_driver :chrome do |app|
          Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
        end
      end

      def create_session
        Capybara.default_driver = :chrome
        Capybara.default_max_wait_time = 10

        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--headless')
        options.add_argument('--disable-gpu')
        options.add_argument('--window-size=1920,1080')

        initialize_driver(options)
      end
    end
  end
end