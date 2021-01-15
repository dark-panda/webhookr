# frozen_string_literal: true

require 'active_support/core_ext/kernel/singleton_class'

module Webhookr
  class Engine < ::Rails::Engine
    isolate_namespace Webhookr

    # Enable basic auth for all services when config.basic_auth.username
    # and config.basic_auth.password are set.
    config.webhookr = ActiveSupport::OrderedOptions.new
    config.webhookr.basic_auth = ActiveSupport::OrderedOptions.new

    initializer 'webhookr.config' do |app|
      # no-op
    end
  end
end
