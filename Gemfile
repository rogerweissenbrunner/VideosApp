source "https://rubygems.org"

# Server
gem "puma", ">= 5.0"
gem "bootsnap", require: false

# Rails
gem "rails", "~> 8.1.2"

# Databases
gem "pg", "~> 1.6"
gem "sqlite3", ">= 2.1"

# Models
gem "bcrypt", "~> 3.1.7"
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Controllers

# Views
gem "jbuilder"

# Assets
gem "propshaft"
gem "thruster", require: false

# HTML

# Images
gem "image_processing", "~> 1.2"

# CSS
gem "tailwindcss-rails"

# JavaScript
gem "importmap-rails"
gem "stimulus-rails"
gem "turbo-rails"

# Timezone information
gem "tzinfo-data", platforms: %i[ windows jruby ]

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "dotenv-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
