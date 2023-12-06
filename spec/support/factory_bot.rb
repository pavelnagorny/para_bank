# frozen_string_literal: true

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

FactoryBot.definition_file_paths = [File.expand_path('../factories/*.rb', __dir__)]
FactoryBot.find_definitions
