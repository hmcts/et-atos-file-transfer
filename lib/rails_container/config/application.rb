require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
# require "action_mailer/railtie"
# require "action_mailbox/engine"
# require "action_text/engine"
require "action_view/railtie"
# require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module EtAtosFileTransfer
  class ContainerApplication < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true

    insights_key = ENV.fetch('AZURE_APP_INSIGHTS_KEY', false)
    if insights_key
      config.azure_insights.enable = true
      config.azure_insights.key = insights_key
      config.azure_insights.role_name = ENV.fetch('AZURE_APP_INSIGHTS_ROLE_NAME', 'et-atos')
      config.azure_insights.role_instance = ENV.fetch('HOSTNAME', 'all')
      config.azure_insights.buffer_size = 500
      config.azure_insights.send_interval = 60
    else
      config.azure_insights.enable = false
    end

  end
end
