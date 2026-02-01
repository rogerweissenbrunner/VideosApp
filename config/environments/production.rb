require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.action_controller.perform_caching = true
  # config.action_mailbox.ingress = :relay
  config.action_mailer.default_url_options = { host: "example.com" }
  config.action_mailer.raise_delivery_errors = false
  config.active_record.attributes_for_inspect = [ :id ]
  config.active_record.dump_schema_after_migration = false
  config.active_storage.service = :local
  config.active_job.queue_adapter = :solid_queue
  config.active_support.report_deprecations = false
  # config.asset_host = "http://assets.example.com"
  config.assume_ssl = true
  config.cache_store = :solid_cache_store
  config.consider_all_requests_local = false
  config.eager_load = true
  config.enable_reloading = false
  config.force_ssl = true
  config.host_authorization = { exclude: ->(request) { request.path == "/up" } }
  config.i18n.fallbacks = true
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.log_tags = [ :request_id ]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.public_file_server.headers = { "cache-control" => "public, max-age=#{1.year.to_i}" }
  config.silence_healthcheck_path = "/up"
  config.solid_queue.connects_to = { database: { writing: :queue } }
  config.ssl_options = { redirect: { exclude: ->(request) { request.path == "/up" } } }

  config.action_mailer.smtp_settings = {
    user_name: Rails.application.credentials.dig(:smtp, :user_name),
    password: Rails.application.credentials.dig(:smtp, :password),
    address: "smtp.example.com",
    port: 587,
    authentication: :plain
  }

  config.hosts = [
    "example.com",
    /.*\.example\.com/
  ]
end
