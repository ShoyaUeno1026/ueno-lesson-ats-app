RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: ENV.fetch("DRIVER", :headless_chrome).to_sym, screen_size: [1400, 1400]
  end
end

Capybara.default_max_wait_time = 10