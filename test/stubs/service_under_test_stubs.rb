module Webhookr
  module Services
    module ServiceUnderTest
      mattr_accessor :callback

      class Adapter
        class << self

          def process(payload)
            [*payload].collect do |p|
              p = Rack::Utils.parse_nested_query(p)
              validate(payload)
              OpenStruct.new({
                :event => p["event"],
                :data => OpenStruct.new(p["data"])
              })
            end
          end

          def validate(payload)
            if payload.nil? || payload == "blort"
              raise Webhookr::InvalidPayloadError.new("'#{payload}' is not valid") 
            end
          end

        end
      end
    end
  end
end

module Webhookr
  module Services
    module ServiceUnderTest
      
      def stub(options = {})
        ops = {
          :service_name => "service_under_test",
          :event => "test_event",
          :email => "gerry@zoocasa.com"
        }.merge(options)
      
        OpenStruct.new({
          :payload => "event=#{ops[:event]}&data[email]=#{ops[:email]}",
          :service_name => ops[:service_name],
          :event => ops[:event],
          :email => ops[:email]
         })
      end

    end
  end
end

class PlainOldCallBackClass
  @@call_count = 0
  @@email = nil

  def self.reset!
    @@call_count = 0
    @@email = nil
  end

  def self.call_count
    @@call_count
  end

  def self.email
    @@email
  end

  def on_test_event(payload)
    @@call_count += 1
    @@email = payload.data.email
  end
end