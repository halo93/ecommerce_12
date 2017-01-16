require_relative "boot"

require "rails/all"
require "roo"

# Require the gems listed in Gemfile, including any gems
# you"ve limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecommerce12
  class Application < Rails::Application
    config.i18n.load_path += Dir[Rails.root.join("config",
      "locales", "**", "*.{rb,yml}").to_s]
  end
end
