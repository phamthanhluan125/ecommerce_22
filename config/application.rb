require_relative "boot"

require "roo"
require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Ecommerce22
  class Application < Rails::Application
    config.time_zone = 'Hanoi'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :en
    config.i18n.available_locales = [:vi, :en]
    config.eager_load_paths << Rails.root.join("lib")
  end
end
