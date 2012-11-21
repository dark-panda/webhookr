module Webhookr
  class AdapterResponse < Struct.new(:event_type, :payload); end
end