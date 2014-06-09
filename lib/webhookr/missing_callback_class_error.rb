
module Webhookr
  class MissingCallbackClassError < RuntimeError
    def initialize(service_name)
      super(%{No callback is configured for the service "#{service_name}".})
    end
  end
end

