source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails',                    '~> 5.1.5'
gem 'pg',                       '>= 0.18', '< 2.0'
gem 'puma',                     '~> 3.7'
gem 'bootstrap-sass',           '~> 3.3.7'
gem 'sass-rails',               '~> 5.0'
gem 'uglifier',                 '>= 1.3.0'

gem 'active_model_serializers', '~> 0.10.7'
gem 'haml',                     '~> 5.0.4'
gem 'webpacker',                '~> 3.3.0'
gem 'react-rails',              '~> 2.4.4'

gem 'will_paginate-bootstrap',  '~> 1.0.1'

group :development, :test do
  gem 'pry',                    '~> 0.11.3'
  gem 'rspec-rails',            '~> 3.7'
  gem 'json_spec',              '~> 1.1.4'
  gem 'shoulda-matchers',       '~> 3.1'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'selenium-webdriver'
  gem 'ffaker'
  gem 'phantomjs'
  gem 'poltergeist'
  gem 'capybara',               '~> 2.13'
  gem 'capybara-webkit'
end

group :development do
  gem 'web-console',            '>= 3.3.0'
  gem 'listen',                 '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen',  '~> 2.0.0'
end
