module Webhookr
  class AdapterResponse < Struct.new(:service_name, :event_type, :payload); end
end