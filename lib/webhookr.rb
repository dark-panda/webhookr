require "webhookr/engine"

module Webhookr
  extend ActiveSupport::Autoload

  autoload :InvalidPayloadError
  autoload :InvalidProtocolError
  autoload :Service
  autoload :VERSION
end
