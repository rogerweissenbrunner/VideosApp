require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Videos
  class Application < Rails::Application
    config.load_defaults 8.1
    config.autoload_lib(ignore: %w[assets generators middleware tasks templates])
    config.time_zone = "America/Santiago"
  end
end
