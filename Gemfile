source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
  # 脆弱性チェック
  gem "brakeman", require: false
  # コードのチェック
  gem "standard", require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"

  # 各モデルのスキーマ情報をファイルの先頭もしくは末尾にコメントで書き出し
  gem "annotate"
  # メールの確認
  gem "letter_opener_web", "~> 2.0"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  # テスト実行時にテストデータをクリア
  gem "database_cleaner-active_record"
  
  gem "selenium-webdriver"
  gem "rspec-rails"
  # テスト用データの作成をサポート
  gem "factory_bot_rails"
  gem "faker"
  # コードカバレッジ分析（テストされたコードの割合）
  gem "simplecov", require: false 
end

# 管理画面生成
gem "administrate", "~> 0.20.0"
gem "administrate-field-active_storage", "~> 1.0"
# 定数管理
gem "config", "~> 5.4"
# 認証機能
gem "devise", "~> 4.9"
# deviceの日本語対応
gem "devise-i18n", "~> 1.12"
# 日本語対応
gem "rails-i18n", "~> 7.0"

gem "name_of_person"
# なりすましログイン
gem "pretender"

gem "enumerize"
gem "inline_svg"