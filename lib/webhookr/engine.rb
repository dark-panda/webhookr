require 'active_support/core_ext/kernel/singleton_class'

module Webhookr
  class Engine < ::Rails::Engine
    isolate_namespace Webhookr

    # Enable basic auth for all services when config.basic_auth.username
    # and config.basic_auth.password are set.
    self.config.webhookr = ActiveSupport::OrderedOptions.new
    self.config.webhookr.basic_auth = ActiveSupport::OrderedOptions.new

    initializer "webhookr.config" do |app|
    end
  end
end

