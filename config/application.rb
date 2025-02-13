require_relative "boot"

require "rails/all"
Bundler.require(*Rails.groups)

module GoTogether
  class Application < Rails::Application
    config.load_defaults 7.2
    config.action_controller.raise_on_missing_callback_actions = false
    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += %W[#{config.root}/app/models]
    config.active_job.queue_adapter = :sidekiq
  end
end
