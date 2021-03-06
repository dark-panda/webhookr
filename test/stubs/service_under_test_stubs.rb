# frozen_string_literal: true

module Webhookr
  module ServiceUnderTest
    class Adapter
      SERVICE_NAME = 'service_under_test'

      include Webhookr::Services::Adapter::Base

      class << self
        def process(payload)
          Array.wrap(payload).collect do |p|
            p = Rack::Utils.parse_nested_query(p)
            validate(payload)
            OpenStruct.new(
              event_type: p['event'],
              data: OpenStruct.new(p['data'])
            )
          end
        end

        def validate(payload)
          raise Webhookr::InvalidPayloadError, payload if payload.nil? || payload == 'blort'
        end
      end
    end
  end
end

module Webhookr
  module ServiceUnderTest
    def stub(options = {})
      ops = {
        service_name: 'service_under_test',
        event_type: 'test_event',
        email: 'foo@example.com'
      }.merge(options)

      OpenStruct.new(
        payload: "event=#{ops[:event_type]}&data[email]=#{ops[:email]}",
        service_name: ops[:service_name],
        event_type: ops[:event_type],
        email: ops[:email]
      )
    end
  end
end

class PlainOldCallBackClass
  @call_count = 0
  @email = nil

  def self.reset!
    @call_count = 0
    @email = nil
  end

  class << self
    attr_accessor :call_count, :email
  end

  def on_test_event(payload)
    self.class.call_count += 1
    self.class.email = payload.data.email
  end
end
