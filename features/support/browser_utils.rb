# frozen_string_literal: true

module Support
  class BrowserUtils
    class << self
      def initialize_driver(options)
        Capybara.register_driver :chrome do |app|
          Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
        end
      end

      # TODO: Fix docker run
      def create_session
        Capybara.default_driver = :chrome
        Capybara.default_max_wait_time = 10

        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')

        unless ENV['PLATFORM'] == 'localhost'
          options.binary = "/usr/bin/chromium"
          options.add_argument('--headless')
          options.add_argument('--user-data-dir=/usr/src/tests/reports/temp/user-data-directory')
        end

        LOGGER.info "Initializing Chrome browser with options: #{options.as_json}"
        begin
          initialize_driver(options)
        rescue StandardError => e
          puts
          LOGGER.error "Error initializing Chrome driver: #{e.message}"
        end
      end
    end
  end
end
