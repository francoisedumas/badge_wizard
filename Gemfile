# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.4"

gem "bootsnap", require: false
gem "devise_invitable"
gem "devise-i18n"
gem "devise"
gem "enumerize"
gem "image_processing", "~> 1.2"
gem "importmap-rails"
gem "pagy"
gem "pg", "~> 1.1"
gem "puma", "~> 5.0"
gem "rails-i18n", "~> 7.0.0"
gem "rails", "~> 7.0.5"
gem "redis", "~> 4.0"
gem "sidekiq-failures", "~> 1.0"
gem "sidekiq"
gem "simple_form", github: "heartcombo/simple_form"
gem "slim-rails"
gem "sprockets-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "view_component"

# Temporary for demonstration
gem "unsplash"

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :development, :test do
  gem "annotate"
  gem "factory_bot_rails", "~> 6.2"
  gem "faker"
  gem "i18n-tasks", "~> 1.0.12"
  gem "pry-byebug"
  gem "pry-rails"
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop-rails", require: false
end

group :test do
  gem "shoulda-matchers"
  gem "webmock"
  gem "vcr"
end
