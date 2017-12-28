# frozen_string_literal: true

require 'test_helper'
require 'stubs/service_under_test_stubs'

module Webhookr
  module Services
    class ServiceUnderTest::AdapterTest < ActiveSupport::TestCase
      def setup
        @event_type = 'test_event'
        @data_msg = 'Hello world!'
        @valid_response = "event=#{@event_type}&data[msg]=#{@data_msg}"
        @invalid_response = 'blort'
      end

      test 'should not raise an exception for a valid payload' do
        assert_nothing_raised do
          Webhookr::ServiceUnderTest::Adapter.process(@valid_response)
        end
      end

      test 'should raise an exception for a invalid payload' do
        assert_raise(Webhookr::InvalidPayloadError) do
          Webhookr::ServiceUnderTest::Adapter.process(@invalid_response)
        end
      end

      test 'should repond with the correct event' do
        responses = Webhookr::ServiceUnderTest::Adapter.process(@valid_response)
        assert_equal(@event_type, responses.first.event_type)
      end

      test 'should respond with valid data' do
        responses = Webhookr::ServiceUnderTest::Adapter.process(@valid_response)
        assert_equal(@data_msg, responses.first.data.msg)
      end
    end
  end
end
