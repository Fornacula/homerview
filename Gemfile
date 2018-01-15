source 'https://rubygems.org'
ruby '2.5.0'

gem 'brakeman'
gem 'chartkick'
# Simple form with validations
gem 'simple_form'
gem 'client_side_validations'
gem 'client_side_validations-simple_form'

gem 'coffee-rails'
gem 'devise', git: 'https://github.com/plataformatec/devise' #, ref: '88e9a85'
gem 'foundation-rails'
# Access controller variables in JavaScript
gem 'gon'
gem 'google-api-client', '< 0.9', require: 'google/api_client'
gem 'groupdate'
# For building JSON APIs
gem 'jbuilder', '~> 2.0'
gem 'jquery-rails'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-google-oauth2'
gem 'pg'
gem 'rails', '5.1.4'
gem 'sass-rails', '~> 5.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'slim-rails'
gem 'uglifier', '>= 1.3.0'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
group :development, :test do
  gem 'dotenv-rails', require: 'dotenv/rails-now'
  gem 'factory_bot_rails', '~> 4.0'
  gem 'faker'
  gem 'pry-byebug'
  gem 'rspec'
  gem 'rspec-rails'
end

group :development do
  gem 'better_errors'
  gem 'bundler-audit'
  gem 'rack-mini-profiler', require: false
  gem 'rails_best_practices'
  gem 'rubocop', '~> 0.52.0', require: false
  gem 'spring'
  gem 'traceroute'
end

group :test do
  gem 'shoulda'
  gem 'simplecov', require: false
end
