require 'test_helper'
require 'stubs/service_under_test_stubs'

module Webhookr
  class ServiceTest < ActiveSupport::TestCase

    include Webhookr::ServiceUnderTest

    test "should raise Webhookr::InvalidServiceNameError for a nil service" do
      assert_raise(Webhookr::InvalidServiceNameError) {
        Webhookr::Service.new(nil)
      }
    end

    test "should raise Webhookr::InvalidServiceNameError for an unknown service" do
      assert_raise(Webhookr::InvalidServiceNameError) {
        Webhookr::Service.new("unknown_service")
      }
    end

    test "should raise a Webhookr::InvalidPayloadError for an invalid payload" do
      assert_raise(Webhookr::InvalidPayloadError) {
        Webhookr::Service.new(
          stub.service_name,
          payload: "blort"
        ).process!
      }
    end

    test "should raise a Webhookr::MissingCallbackClassError error if there is no callback class configured" do
      Webhookr::ServiceUnderTest::Adapter.config.callback = nil
      assert_raise(Webhookr::MissingCallbackClassError) {
        Webhookr::Service.new(
          stub.service_name,
          payload: stub.payload
        ).process!
      }
    end
  end

  class ServiceTest < ActiveSupport::TestCase
    include Webhookr::ServiceUnderTest

    def setup
      Webhookr::ServiceUnderTest::Adapter.config.callback = PlainOldCallBackClass
      PlainOldCallBackClass.reset!
    end

    test "should accept a callback class configuration" do
      assert_nothing_raised {
        Webhookr::ServiceUnderTest::Adapter.config.callback = Object
      }
    end

    test "process! should not raise a Webhookr::InvalidPayloadError for a valid payload" do
      assert_nothing_raised {
        Webhookr::Service.new(
          stub.service_name,
          payload: stub.payload
        ).process!
      }
    end

    test "a service should be initialized" do
      # pending "more time" do
      #   assert_false
      # end
    end

    test "process! should silently ignore on_event not present in callback class" do
      assert_nothing_raised {
        Webhookr::Service.new(
          stub.service_name,
          payload: stub(:event_type => "no_event").payload
        ).process!
      }
    end

    test "process! should call the on_event method of the callback class for a valid payload" do
      Webhookr::Service.new(stub.service_name, payload: stub.payload).process!
      assert_equal PlainOldCallBackClass.call_count, 1
    end

    test "process! should have the payload data email" do
      email = "test@test.com"
      Webhookr::Service.new(
        stub.service_name,
        payload: stub(:email => email).payload
      ).process!
      assert_equal(email, PlainOldCallBackClass.email)
    end

    test "process! should process multiple records" do
      Webhookr::Service.new(
        stub.service_name,
        payload: [ stub.payload, stub.payload ]
      ).process!
      assert_equal 2, PlainOldCallBackClass.call_count
    end
  end
end
