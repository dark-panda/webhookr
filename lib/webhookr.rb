require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :AdapterResponse
  autoload :Service
  autoload :VERSION

  class << self
    def config
      if defined?(@config)
        @config
      else
        @config = if defined?(Rails)
          Rails.application.config.webhookr
        else
          ActiveSupport::OrderedOptions.new
        end
      end
    end
  end
end
