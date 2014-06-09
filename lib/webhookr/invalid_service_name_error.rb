
module Webhookr
  class InvalidServiceNameError < NameError
    def initialize(service_name)
      super(%{Bad service name "#{service_name}"})
    end
  end
end

