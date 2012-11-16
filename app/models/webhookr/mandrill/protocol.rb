module Webhookr
  class Mandrill::Protocol
    EVENT_KEY = 'event'
    EVENT_DATE_KEY = 'ts'
    DATA_KEY = "msg"

    def self.process(raw_response)
      new.process(raw_response)
    end

    def process(raw_response)
      raise(Webhookr::InvalidProtocolError, "Unknown response |#{raw_response.inspect}|") unless raw_response =~ /mandrill_events=/

      p = ActiveSupport::JSON.decode(CGI.unescape(raw_response).gsub(/mandrill_events=/,""))
      assert_valid_packet(p)

      p.collect do |item|
        OpenStruct.new(:event_type => item[EVENT_KEY],
                       :fired_at => item[EVENT_DATE_KEY],
                       :protocol => self.class.name,
                       :data => OpenStruct.new(item[DATA_KEY]))
      end
    end

    private

    def assert_valid_packet(p)
      raise(Webhookr::InvalidProtocolError, "Malformed response |#{p.inspect}|") unless p.is_a?(Array) && p.first.is_a?(Hash)

      p.each do |item|
        raise(Webhookr::InvalidProtocolError, "Unknown event #{item[EVENT_KEY]}") unless item[EVENT_KEY]
        raise(Webhookr::InvalidProtocolError, "No msg in the response") unless item[DATA_KEY]
      end
    end

  end
end
