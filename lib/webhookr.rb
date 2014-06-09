require "securecompare"
require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :InvalidSecurityTokenError
  autoload :InvalidServiceNameError
  autoload :MissingCallbackClassError
  autoload :AdapterResponse
  autoload :Service
  autoload :VERSION

  class << self
    def adapters
      @adapters ||= HashWithIndifferentAccess.new
    end

    def config
      @config ||= if defined?(Rails)
        Rails.application.config.webhookr
      else
        ActiveSupport::OrderedOptions.new
      end
    end
  end
end

require "webhookr/services"

