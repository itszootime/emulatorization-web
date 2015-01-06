source 'http://rubygems.org'
ruby '1.9.3'

gem 'rails', '~> 3.2.11'

gem 'foreman'
gem 'simple_form'

# Web server
gem 'thin'

# Database
gem 'mongoid'
gem 'bson_ext'

# Background tasks
gem 'delayed_job_mongoid'
gem 'daemons'

# Deploy
gem 'capistrano'

# Authentication
gem 'devise', '~> 2.0.0'
gem 'cancan'

# Uploads
gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
gem 'rmagick', '2.13.2'

# Test
group :development, :test do
  gem 'debugger'
  gem 'rspec-rails', '~> 2.12.0'
  gem 'spork', '0.9.2'
end

group :test do
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'mongoid-rspec'
  gem 'database_cleaner'
  gem 'capybara', '~> 2.4'
end

# Asset related
gem 'therubyracer', '0.12.1'
gem 'jquery-rails'

group :assets do
  # JavaScript compressor
  gem 'uglifier'

  # Less rails
  gem 'less-rails-bootstrap'
end