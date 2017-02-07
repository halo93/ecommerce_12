source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.0.1"
# Use Puma as the app server
gem "puma", "~> 3.0"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem "therubyracer", platforms: :ruby

# Use jquery as the JavaScript library
gem "jquery-rails"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
gem "rubocop", "~> 0.46.0", require: false
gem "materialize-sass"
gem "i18n-js", ">= 3.0.0.rc11"
gem "flag-icons-rails"
gem "config"
gem "devise"
gem "omniauth-facebook"
gem "cancancan"
gem "simple_form"
gem "kaminari"
gem "ransack"
gem "ffaker"
gem "carrierwave"
gem "mini_magick"
gem "fog"
gem "friendly_id"
gem "social-share-button"
gem "roo"
gem "ratyrate"
gem "whenever"
gem "sidekiq"
gem "delayed_job_active_record"
gem "figaro"
gem "chartkick"
gem "groupdate", github: "ankane/groupdate", branch: "sqlite"

group :development, :test do
  gem "byebug", platform: :mri
  gem "sqlite3"
  gem "rspec-rails"
  gem "factory_girl_rails"
  gem "simplecov"
  gem "rails-controller-testing"
end

group :test do
  gem "shoulda-matchers"
  gem "database_cleaner"
  gem "faker"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "pg", "0.18.4"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
