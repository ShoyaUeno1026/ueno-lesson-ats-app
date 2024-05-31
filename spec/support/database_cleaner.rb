# frozen_string_literal: true

RSpec.configure do |config|
  DatabaseCleaner.strategy = :truncation
  DatabaseCleaner.clean_with :truncation

  config.after(:suite) do
    DatabaseCleaner.clean
  end
end
