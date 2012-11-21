require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :AdapterResponse
  autoload :Service
  autoload :VERSION
end
