require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :AdapterResponse
  autoload :Service
  autoload :VERSION

  class << self
    def config
      @config ||= defined?(Rails) ? Rails.application.config.webhookr :
                                    ActiveSupport::OrderedOptions.new
    end
  end
end
