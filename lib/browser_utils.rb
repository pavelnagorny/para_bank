# frozen_string_literal: true

module Support
  class BrowserUtils
    class << self
      # Register driver
      def register_chrome_driver(options)
        Capybara.register_driver :chrome do |app|
          Capybara::Selenium::Driver.new(app, browser: :chrome, options:)
        end
      end

      def register_appium_android_driver
        Capybara.register_driver(:appium_android) do |app|
          caps = Appium.load_appium_txt file: File.join(Dir.pwd, 'appium_config_android.yml')

          Appium::Capybara::Driver.new(app, **caps)
        end
      end

      # Create driver session
      def create_web_session
        Capybara.default_driver = :chrome
        Capybara.default_max_wait_time = 10

        options = Selenium::WebDriver::Chrome::Options.new
        options.add_argument('--disable-gpu')
        options.add_argument('--no-sandbox')
        options.add_argument('--disable-dev-shm-usage')

        unless ENV['PLATFORM'] == 'localhost'
          options.binary = '/usr/bin/chromium'
          options.add_argument('--headless')
          options.add_argument('--user-data-dir=/usr/src/tests/reports/temp/user-data-directory')
        end

        LOGGER.info "Initializing Chrome browser with options: #{options.as_json}"
        begin
          register_chrome_driver(options)
        rescue StandardError => e
          LOGGER.error "Error initializing Chrome driver: #{e.message}"
        end
      end

      def create_android_session
        Capybara.default_driver = :appium_android
        LOGGER.info 'Initializing Android emulator'
        begin
          register_appium_android_driver
        rescue StandardError => e
          LOGGER.error "Error initializing Android emulator driver: #{e.message}"
        end
      end
    end
  end
end
