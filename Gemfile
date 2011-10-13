source 'http://rubygems.org'

gem 'rake', '0.8.7'

gem 'rails', '3.0.10'
gem 'sqlite3-ruby', :require => 'sqlite3'

gem 'ancestry'
gem 'friendly_id'
gem 'omniauth'
gem 'will_paginate', '3.0.pre2'
gem 'meta_search'
gem 'diff-lcs'
gem 'twitter'

# view
gem 'slim'
gem "slim-rails"
gem 'sass'
gem 'jquery-rails', '>= 1.0.3'

# tools
gem 'nokogiri'


# Use unicorn as the web server
group :development do
  gem 'thin'
end

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
group :development, :test do
  gem 'fabrication'
end

group :test do
#  gem 'turn'
  gem 'simplecov'
  gem 'fakeweb'
  gem 'shoulda-context'
  gem 'spork'
  gem 'spork-testunit'
#  gem 'test-unit'
  gem 'pg'
end
