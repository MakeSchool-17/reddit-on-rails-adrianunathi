source 'https://rubygems.org'

ruby "2.2.4"
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'web-console', '~> 3.1', '>= 3.1.1', group: :development

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring', '~> 1.6', '>= 1.6.3'
  gem 'sqlite3', '~> 1.3', '>= 1.3.11'
  gem 'byebug', '~> 8.2', '>= 8.2.2'
  gem 'pry'
end

group :test do
  gem 'minitest-reporters', '~> 1.1', '>= 1.1.8'
  gem 'mini_backtrace', '~> 0.1.3'
  gem 'guard-minitest', '~> 2.4', '>= 2.4.4'
  gem 'guard', '~> 2.13'
  gem 'simplecov', :require => false
end

group :production do
  gem 'pg', '~> 0.18.4'
  gem 'rails_12factor', '~> 0.0.3'
  gem 'puma', '~> 3.1'
end
