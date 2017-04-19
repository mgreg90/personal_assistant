source 'https://rubygems.org'
ruby '2.4.0'
# For turning numbers to text
gem 'humanize'

# For handling keys
gem 'dotenv-rails', :require => 'dotenv/rails-now'

# For parsing time from messages
gem 'chronic'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

# For generating an erd
gem 'rails-erd'

# For configuring slack
gem 'slack-ruby-bot'
gem 'celluloid-io'

# For parsing dates and times from text
gem 'gregorian', git: 'git://github.com/mgreg90/gregorian.git'

group :development, :test do

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'pry'
  gem 'pry-rails'
  gem 'pry-nav'

  gem 'awesome_print', require:"ap"

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'timecop'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
