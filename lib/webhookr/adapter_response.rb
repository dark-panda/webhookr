# frozen_string_literal: true

module Webhookr
  AdapterResponse = Struct.new(:service_name, :event_type, :payload)
end
