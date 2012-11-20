module Webhookr
    # Enable basic auth for all services when config.basic_auth.username
    # and config.basic_auth.password are set.
    mattr_accessor :config
    self.config = ActiveSupport::OrderedOptions.new
    self.config.basic_auth = ActiveSupport::OrderedOptions.new

  class Engine < ::Rails::Engine
    isolate_namespace Webhookr
  end
end
