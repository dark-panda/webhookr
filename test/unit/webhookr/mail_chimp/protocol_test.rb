require 'test_helper'

module Webhookr
  class MailChimp::ProtocolTest < ActiveSupport::TestCase

    def setup
      @event_type = "unsubscribe"
      @fired_at = "2009-03-26 22:01:00"
      @valid_response = "type=#{@event_type}&fired_at=#{@fired_at}&data[email]=gerry%2Bagent2@zoocasa.com"
    end

    test "should not raise an exception for a valid packet" do
      assert_nothing_raised() { Webhookr::MailChimp::Protocol.process(@valid_response) }
    end

    test "should return the correct data type" do
      response = Webhookr::MailChimp::Protocol.process(@valid_response)
      assert_equal(response.event_type, @event_type)
    end

    test "should return the correct data packet" do
      response = Webhookr::MailChimp::Protocol.process(@valid_response)
      assert_equal(response.data.email, "gerry+agent2@zoocasa.com")
    end

    test "should have the correct protocol" do
      response = Webhookr::MailChimp::Protocol.process(@valid_response)
      assert_equal(response.protocol, "Webhookr::MailChimp::Protocol")
    end

    test "should have the correct event fired date" do
      response = Webhookr::MailChimp::Protocol.process(@valid_response)
      assert_equal(response.fired_at, @fired_at)
    end

    test "should raise MailObserver::InvalidProtocolError for no packet" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::MailChimp::Protocol.process("")
      }
    end

    test "should raise MailObserver::InvalidProtocolError for a missing event type" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::MailChimp::Protocol.process("data[email]=gerry%2Bagent2@zoocasa.com")
      }
    end

    test "should raise MailObserver::InvalidProtocolError for a missing data packet" do
      assert_raise(Webhookr::InvalidProtocolError) {
        Webhookr::MailChimp::Protocol.process("type=unsubscribe")
      }
    end
  end
end
