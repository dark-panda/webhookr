module Webhookr
  class MailChimp::Protocol
    EVENT_KEY = "type"
    EVENT_DATE_KEY = "fired_at"
    DATA_KEY = "data"
    KNOWN_EVENTS = %w{ subscribe unsubscribe cleaned profile upemail campaign }

    def self.process(raw_response)
      new.process(raw_response)
    end

    def process(raw_response)
      p = Rack::Utils.parse_nested_query(raw_response)
      assert_valid_packet(p)

      return [ OpenStruct.new(:event_type => p[EVENT_KEY],
                            :fired_at => p[EVENT_DATE_KEY],
                            :protocol => self.class.name,
                            :data => OpenStruct.new(p[DATA_KEY])) ]
    end

    private
    
    def assert_valid_packet(parsed_response)
      raise(Webhookr::InvalidProtocolError, "Missing event key '#{EVENT_KEY}' in packet") unless parsed_response[EVENT_KEY].present?
      raise(Webhookr::InvalidProtocolError, "No data key '#{DATA_KEY}' in the response") unless parsed_response[DATA_KEY].present?
    end

  end
end
