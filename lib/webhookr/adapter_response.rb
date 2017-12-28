# frozen_string_literal: true

module Webhookr
  class AdapterResponse < Struct.new(:service_name, :event_type, :payload); end
end
