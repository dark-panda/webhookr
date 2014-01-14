require "securecompare"
require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :AdapterResponse
  autoload :Service
  autoload :VERSION

  class << self
    def adapters
      @adapters ||= HashWithIndifferentAccess.new
    end

    def config
      @config ||= defined?(Rails) ? Rails.application.config.webhookr :
                                    ActiveSupport::OrderedOptions.new
    end
  end
end

require "webhookr/services"

